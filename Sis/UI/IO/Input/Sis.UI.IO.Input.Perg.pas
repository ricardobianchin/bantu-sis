unit Sis.UI.IO.Input.Perg;

interface

uses Sis.Types.Utils_u;

function PergBool(pPergunta: string; pCaption: string = '';
  pDefaultResult: TBooleanDefault = TBooleanDefault.boolUndefined): boolean;
// function Perg(pFrase: string; pCaption: string = 'Pergunta...'): boolean;

implementation

uses Sis.UI.IO.Input.Bool.Caption.Form_u, {Vcl.Dialogs,} Vcl.Controls,
  WinApi.Windows, Vcl.Forms;

(*
  function PergBool(pPergunta: string; pCaption: string = '';
  pDefaultResult: TBooleanDefault = TBooleanDefault.boolUndefined): boolean;
  begin
  result := False;
  end;
*)

function PergBool(pPergunta: string; pCaption: string = '';
  pDefaultResult: TBooleanDefault = TBooleanDefault.boolUndefined): boolean;
var
  Resultado: integer;
begin
  Resultado := MessageBox(Application.Handle, PWideChar(pPergunta),
    PWideChar(pCaption), MB_YESNO + MB_ICONEXCLAMATION + +MB_DEFBUTTON1);
  Result := Resultado = ID_YES;
  // Result := IsPositiveResult(MessageDlg(pFrase, TMsgDlgType.mtInformation, [mbYes, mbNo], 0, TMsgDlgBtn.mbNo));
end;

// function Perg(pFrase: string; pCaption: string): boolean;
// begin
// PergBooleanForm := TPergBooleanForm.Create(nil);
// try
// PergBooleanForm.Caption := pCaption;
// PergBooleanForm.MensagemLabel.Caption := pFrase;
// Result := PergBooleanForm.Perg;
// finally
// PergBooleanForm.Free;
// end;
//
// end;

end.
