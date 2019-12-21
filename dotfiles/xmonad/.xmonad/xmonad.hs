import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicBars
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.SpawnOnce
import XMonad.Actions.SpawnOn
import System.IO
import Graphics.X11.ExtraTypes.XF86
import XMonad.Layout.Spacing
import XMonad.Layout.TwoPane
import XMonad.Layout.ResizableTile
import XMonad.Layout.Named
import XMonad.Layout.NoBorders

myLayout = avoidStruts $
        tiled
    ||| mirror
    ||| full
  where
      tiled = named "tall" $ spacing gap $ ResizableTall nmaster delta ratio []
      mirror = named "mirror" $ Mirror $ spacing gap $ ResizableTall nmaster delta ratio []
      full = noBorders $ named "full" $ Full
      nmaster = 1
      ratio = 1/2
      delta = 3/100
      gap = 3

main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ docks defaultConfig
        { manageHook = manageSpawn <+> manageDocks <+> manageHook defaultConfig
        , focusedBorderColor = "#FFFFFF"
        , normalBorderColor = "#000000"
        , borderWidth = 2
        , terminal = "alacritty"
        , workspaces = ["one", "two", "three", "four", "five", "six"]
        , startupHook = spawnHere "stanlonetray"
                     >> spawnHere "nm-applet"
                     >> spawnHere "feh --bg-scale ~/.xmonad/background.jpg"
        , layoutHook = myLayout
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        } `additionalKeys`
        [ ((mod1Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock; xset dpms force off")
        , ((mod1Mask .|. shiftMask, xK_r), spawn "~/config/bin/initx.sh")
        , ((mod1Mask .|. shiftMask, xK_p), spawn "keepassxc")

        , ((0,           xF86XK_AudioLowerVolume), spawn "amixer -q -D pulse sset Master 10%-")
        , ((0,           xF86XK_AudioRaiseVolume), spawn "amixer -q -D pulse sset Master 10%+")
        , ((0,           xF86XK_AudioMute),        spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
        , ((0,           xF86XK_AudioMicMute),     spawn "amixer -q -D pulse sset Capture toggle")

        , ((0,           xF86XK_MonBrightnessDown), spawn "brightnessctl s 10%-")
        , ((0,           xF86XK_MonBrightnessUp), spawn "brightnessctl s +10%")

        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
	]
