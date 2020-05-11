import XMonad
import XMonad.Layout.BinarySpacePartition
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.Navigation2D
import System.IO

myLayout = emptyBSP
altMask = mod1Mask
ctrlMask = mod2Mask

main = do xmonad 
  $ navigation2D def
    --(xK_Up, xK_Left, xK_Down, xK_Right)
    (xK_k, xK_h, xK_j, xK_l)
    [(mod4Mask,               windowGo  ),
     (mod4Mask .|. shiftMask, windowSwap)]
    False
  -- $ def
  $ defaultConfig
    { manageHook = manageDocks <+> manageHook defaultConfig
    --, layoutHook = avoidStruts  $  layoutHook defaultConfig
    , layoutHook = myLayout
    , modMask = mod4Mask -- rebind mod to windows key
    , terminal = "urxvt"
    } `additionalKeys`
    [ ((mod4Mask .|. altMask,               xK_l     ), sendMessage $ ExpandTowards R)
    , ((mod4Mask .|. altMask,               xK_h     ), sendMessage $ ExpandTowards L)
    , ((mod4Mask .|. altMask,               xK_j     ), sendMessage $ ExpandTowards D)
    , ((mod4Mask .|. altMask,               xK_k     ), sendMessage $ ExpandTowards U)
    , ((mod4Mask .|. altMask .|. ctrlMask , xK_l     ), sendMessage $ ShrinkFrom R)
    , ((mod4Mask .|. altMask .|. ctrlMask , xK_h     ), sendMessage $ ShrinkFrom L)
    , ((mod4Mask .|. altMask .|. ctrlMask , xK_j     ), sendMessage $ ShrinkFrom D)
    , ((mod4Mask .|. altMask .|. ctrlMask , xK_k     ), sendMessage $ ShrinkFrom U)
    , ((mod4Mask,                           xK_r     ), sendMessage Rotate)
    , ((mod4Mask,                           xK_s     ), sendMessage Swap)
    , ((mod4Mask,                           xK_u     ), sendMessage FocusParent)
    -- , ((mod4Mask .|. mod1Mask,  xK_Up),    sendMessage $ FlipH)
    -- , ((mod4Mask .|. mod1Mask,  xK_Down),  sendMessage $ FlipV)
    , ((mod4Mask .|. mod1Mask,  xK_Right), sendMessage $ RotateR)
    , ((mod4Mask .|. mod1Mask,  xK_Left),  sendMessage $ RotateL)
    -- , ((mod4Mask, xK_a), sendMessage Balance)
    -- , ((mod4Mask, xK_f), sendMessage CirculateR)
    -- , ((mod4Mask, xK_g), sendMessage CirculateL)
    ]
