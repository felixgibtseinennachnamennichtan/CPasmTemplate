.section .header
/* APP_NAME        */ .string "Hello World2"
/* APP_DESCRIPTION */ .string "This is a simple Hello World program"
/* APP_AUTHOR      */ .string "SnailMath"
/* APP_VERSION     */ .string "1.0.0"
.section .text
.align 1 !make sure everything is aligned.

.global _main
_main:

!back up everything
mov.l r8, @-r15 !Back up r8
mov.l r9, @-r15 !Back up r9
sts.l pr, @-r15 !Back up pr

!Load subroutine addresses
mov.l setCursor, r8
mov.l printString, r9

!Set the Cursor to (0,1)
mov #0, r4 !x=0
jsr @r8 !setCursor is in r8
mov #1, r5 !y=1 (this gets executed before the jsr, because it is in a delay slot)

!Print the text
mova text, r0
mov r0, r4 !The addr ofthe text is now in r4
jsr @r9 !print is in r9
mov #0, r5 !0 in r5 (this gets executed before the jsr, because it is in a delay slot)

!Set the Cursor to (2,15)
mov  #2, r4 !x=2
jsr @r8 !setCursor is in r8
mov #15, r5 !y=15 (this gets executed before the jsr, because it is in a delay slot)

!Print the other text
mova text2, r0
mov r0, r4 !The addr ofthe text is now in r4
jsr @r9 !print is in r9
mov #1, r5 !1 in r5 (invert color) (this gets executed before the jsr, because it is in a delay slot)

!Refresh the LCD
mov.l refresh, r2
jsr @r2
nop !(delay slot)

!restore everything
lds.l @r15+, pr !Restore pr
mov.l @r15+, r9 !Restore r9
mov.l @r15+, r8 !Restore r8

rts !return subroutine
nop !(delay slot)



.align 2 !make sure everything is aligned.
setCursor:
  .long _Debug_SetCursorPosition
printString:
  .long _Debug_PrintString
refresh:
  .long _LCD_Refresh


.align 2 !make sure everything is aligned.
text:
  .string "Hello World"


.align 2 !make sure everything is aligned.
text2: 
  .string "SnailMath!"



