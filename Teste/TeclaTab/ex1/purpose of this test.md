# purpose of this test

I have a form defined in the .pas and .dfm files.

I want that when the user presses the [Tab] key and the focus is on `MaskEdit1`, the caption 'The [Enter] key was pressed' appears on `Label1`

The problem is that the TMaskEdit control, as all TWinControl descendants, captures the Message of the Tab key pressing, so that the focus moves to the next control. This is good. I want it to stay that way. But it prevents me from using the onkeypress event or the onkeydown event or the onkeyup event programming to detect the tab key, because these events are not fired when tab is pressed.

Maybe we need to create a procedure that would receive the WM_KEYDOWN message, something like `procedure LookUpForTab(var Msg: TMessage); message WM_KEYDOWN;`, which would return to Windows that the message was not handled and the following controls would continue to receive the message, thus, MaskEdit1 would have a chance to send the focus to the following control. This method would test the code of the pressed key, and, if it was Tab, VK_TAB, it would execute `Label1.Caption := 'The [Tab] key was pressed';`.

How to solve this? Does this way work or do you suggest a better one?

