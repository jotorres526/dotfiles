import System.IO
import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys, additionalMouseBindings)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Config.Desktop
import XMonad.Actions.SpawnOn
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Layout.Cross(simpleCross)
import XMonad.Layout.Spiral(spiral)
import XMonad.Layout.ThreeColumns
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.IndependentScreens
import XMonad.Layout.CenteredMaster(centerMaster)
import Control.Monad (liftM2)
import qualified Codec.Binary.UTF8.String as UTF8
import qualified Data.ByteString as B
import qualified Data.Map as M
import qualified XMonad.StackSet as W

-- trying the following color pallet
-- pink   = #ff71ce (focused)
-- purple = #b967ff (unfocused)
-- yellow = #fffb96 (hidden)
-- black  = #1c1c1c (background)
-- blue   = #01cdfe (random 2)
-- green  = #05ffa1 (random 2)


-- Startup hook
myStartupHook = do
    spawn "$HOME/.xmonad/scripts/autostart.sh"
    setWMName "LG3D"

-- Colors
normBord = "#b967ff"
focdBord = "#ff71ce"

myModMask     = mod4Mask
encodeCChar   = map fromIntegral . B.unpack
myBorderWidth = 2
myWorkspaces  = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
myBaseConfig  = docks def
myTerminal    = "kitty"
myFont        = "xft:Ubuntu:weight=bold:pixelsize=12:antialias=true:hinting=true"


-- Window manipulations
myManageHook = composeAll . concat $
    [
        [isDialog       --> doCenterFloat], -- Dialogs should be floating and centered
        [className =? c --> doCenterFloat | c <- myCFloats],
        [title =? t     --> doFloat       | t <- myTitleFloats],
        [resource =? rf --> doFloat       | rf <- myResFloats],
        [resource =? ri --> doIgnore      | ri <- myIgnores],
        [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo "I"    | x <- my1Shifts],
        [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo "II"   | x <- my2Shifts],
        [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo "III"  | x <- my3Shifts],
        [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo "IV"   | x <- my4Shifts],
        [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo "V"    | x <- my5Shifts],
        [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo "VI"   | x <- my6Shifts],
        [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo "VII"  | x <- my7Shifts],
        [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo "VIII" | x <- my8Shifts],
        [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo "X"    | x <- my9Shifts]
    ] where
        doShiftAndGo  = doF .  liftM2 (.) W.greedyView W.shift
        myCFloats     = ["Gnome-calculator", "Pavucontrol"]
        myTitleFloats = ["Downloads", "Save As...", "Friends List"]
        myResFloats   = []
        myIgnores     = ["desktop_window"]
        my1Shifts     = ["kitty"]
        my2Shifts     = ["discord"]
        my3Shifts     = ["Spotify"]
        my4Shifts     = ["Firefox", "Chromium", "Google-chrome", "Brave-browser"]
        my5Shifts     = []
        my6Shifts     = []
        my7Shifts     = []
        my8Shifts     = []
        my9Shifts     = []


-- Layouts
myLayout = spacingRaw True (Border 0 5 5 5) True (Border 5 5 5 5) True $ avoidStruts $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) $ smartBorders $ tiled ||| Mirror tiled ||| spiral (6/7)  ||| ThreeColMid 1 (3/100) (1/2) ||| Full
    where
        tiled       = Tall nmaster delta tiled_ratio
        nmaster     = 1
        delta       = 3/100
        tiled_ratio = 1/2

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad . ewmh $ myBaseConfig
        {
            startupHook = myStartupHook,
            layoutHook  =  avoidStruts $ gaps [(U,5), (D,5), (R,5), (L,5)] $ myLayout,
            logHook = dynamicLogWithPP xmobarPP {
                ppCurrent         = xmobarColor "#ff71ce" "" . wrap "[" "]",
                ppHidden          = xmobarColor "#b967ff" "",
                ppHiddenNoWindows = xmobarColor "#fffb96" "",
                ppOutput          = hPutStrLn xmproc,
                ppLayout          = xmobarColor "#01cdfe" "" . (\layout -> case layout of
                    "Spacing Tall"        -> "[ | ]"
                    "Spacing Mirror Tall" -> "[---]"
                    "Spacing Spiral"      -> "[ @ ]"
                    "Spacing ThreeCol"    -> "[ || ]"
                    "Spacing Full"        -> "[   ]"
                ),
                ppTitle = xmobarColor "#ff71ce" "" . shorten 50
            },
            manageHook         = manageSpawn <+> myManageHook <+> manageHook myBaseConfig,
            modMask            = myModMask,
            terminal           = myTerminal,
            borderWidth        = myBorderWidth,
            handleEventHook    = fullscreenEventHook <+> handleEventHook myBaseConfig,
            workspaces         = myWorkspaces,
            focusedBorderColor = focdBord,
            normalBorderColor  = normBord
        }`additionalKeys`
        [
            -- MULTIMEDIA
            ((0         , xF86XK_AudioMute)         , spawn "amixer -qD pulse sset Master toggle"),
            ((0         , xF86XK_AudioLowerVolume)  , spawn "amixer -qD pulse sset Master 5%-"),
            ((0         , xF86XK_AudioRaiseVolume)  , spawn "amixer -qD pulse sset Master 5%+"),
            ((0         , xF86XK_MonBrightnessUp)   , spawn "xbacklight -inc 5"),
            ((0         , xF86XK_MonBrightnessDown) , spawn "xbacklight -dec 5"),
            ((myModMask , xF86XK_AudioMute)         , spawn "playerctl play-pause"),
            ((myModMask , xF86XK_AudioRaiseVolume)  , spawn "playerctl next"),
            ((myModMask , xF86XK_AudioLowerVolume)  , spawn "playerctl previous"),
            --WM Keys
            ((myModMask .|. shiftMask , xK_l)   , spawn "xfce4-screensaver-command -l"),
            ((myModMask               , xK_p)   , spawn "rofi -show drun -theme themes/drun.rasi"),
            ((myModMask               , xK_Tab) , spawn "rofi -show window -theme themes/window.rasi"),
            ((myModMask .|. shiftMask , xK_q)   , spawn "~/.config/rofi/scripts/powermenu.sh"),
            -- APP LAUNCH
            ((myModMask .|. shiftMask , xK_f) , spawn "pcmanfm"),
            ((myModMask .|. shiftMask , xK_w) , spawn "brave"),
            ((myModMask .|. shiftMask , xK_e) , spawn "kitty nvim"),
            ((myModMask .|. shiftMask , xK_p) , spawn "bash -c 'if ! pkill -x picom; then exec picom; fi'"),
            ((myModMask .|. shiftMask , xK_n) , spawn "kitty nmtui-connect"),
            ((myModMask .|. shiftMask , xK_m) , spawn "spotify"),
            -- SCREENSHOTS
            ((0         , xK_Print) , spawn "flameshot full -c" ),
            ((myModMask , xK_Print) , spawn "flameshot gui")
        ]
