unit App.DB.Import.Input.Barras_u;

interface

uses Sis.UI.IO.Input.Str, App.DB.Import.Prod.Barras.Ed.Form_u;

type
  TImportInputBarras = class(TInterfacedObject, IInputStr)
  public
    function EditStr(var Value: string; pTit: string = ''; pCaption: string = ''): boolean;
  end;

implementation

uses System.SysUtils;

{ TImportInputBarras }

function TImportInputBarras.EditStr(var Value: string; pTit: string = ''; pCaption: string = ''): boolean;
begin
  ImportBarEdForm := TImportBarEdForm.Create(nil);
  try
    if pTit <> '' then
      ImportBarEdForm.Caption := pTit;

    if pCaption <> '' then
      ImportBarEdForm.LabeledEdit1.EditLabel.Caption := pCaption;

    ImportBarEdForm.LabeledEdit1.Text := Value;

    Result := ImportBarEdForm.Perg;

    if not Result then
      exit;

    Value := ImportBarEdForm.LabeledEdit1.Text;

  finally
    FreeAndNil(ImportBarEdForm);
  end;

end;

end.
