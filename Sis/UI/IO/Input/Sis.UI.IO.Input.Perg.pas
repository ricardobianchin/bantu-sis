unit Sis.UI.IO.Input.Perg;

interface

function Perg(pFrase: string; pCaption: string = 'Pergunta...'): boolean;

implementation

uses Sis.UI.IO.Input.Bool.Form;

function Perg(pFrase: string; pCaption: string): boolean;
begin
  PergBooleanForm := TPergBooleanForm.Create(nil);
  try
    PergBooleanForm.Caption := pCaption;
    PergBooleanForm.MensagemLabel.Caption := pFrase;
    Result := PergBooleanForm.Perg;
  finally
    PergBooleanForm.Free;
  end;

end;

end.
