unit ShopApp.DB.Import.Form.PLUBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.DB.Import.Form_u, Vcl.ExtCtrls,
  Vcl.StdCtrls, Sis.UI.Controls.Files.FileSelectLabeledEdit.Frame, Data.DB,
  Vcl.Grids, Vcl.DBGrids, App.AppObj;

type
  TShopDBImportFormPLUBase = class(TDBImportForm)
  private
    { Private declarations }
    FFileSelectFrame: TFileSelectLabeledEditFrame;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj);
  end;

var
  ShopDBImportFormPLUBase: TShopDBImportFormPLUBase;

implementation

{$R *.dfm}

{ TShopDBImportFormPLUBase }

constructor TShopDBImportFormPLUBase.Create(AOwner: TComponent; pAppObj: IAppObj);
begin
  inherited;
end;

end.
