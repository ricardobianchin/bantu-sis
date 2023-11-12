unit Sis.Teste.UI.IO.Outputs;

interface

procedure SimunlaLabelSetCaption(pFrase: string);

implementation

uses Vcl.Dialogs;

procedure SimunlaLabelSetCaption(pFrase: string);
begin
  ShowMessage('teste label set caption ' + pFrase);
end;

end.
