unit Sis.UI.IO.Input.Perg;

interface

function PergBool(pFrase: string): boolean;
//function Perg(pFrase: string; pCaption: string = 'Pergunta...'): boolean;

implementation

uses Sis.UI.IO.Input.Bool.Form, Vcl.Dialogs, Vcl.Controls;

function PergBool(pFrase: string): boolean;
begin
  Result := IsPositiveResult(MessageDlg(pFrase, TMsgDlgType.mtInformation, [mbYes, mbNo], 0, TMsgDlgBtn.mbNo));
end;

//function Perg(pFrase: string; pCaption: string): boolean;
//begin
//  PergBooleanForm := TPergBooleanForm.Create(nil);
//  try
//    PergBooleanForm.Caption := pCaption;
//    PergBooleanForm.MensagemLabel.Caption := pFrase;
//    Result := PergBooleanForm.Perg;
//  finally
//    PergBooleanForm.Free;
//  end;
//
//end;

end.
