unit ShopApp.DB.Import.Form.PLUBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.DB.Import.Form_u, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, App.AppObj, System.Actions, Vcl.ActnList, Vcl.Buttons,
  App.DB.Import.Origem, App.DB.Import, Sis.UI.IO.Output, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog,
  Sis.UI.Controls.Files.FileSelectLabeledEdit.Frame;

type
  TShopDBImportFormPLUBase = class(TDBImportForm)
    MoldeFileSelectPanel: TPanel;
  private
    { Private declarations }
    FFileSelectFrame: TFileSelectLabeledEditFrame;
  protected
    function DBImportCreate(pDestinoDBConnection: IDBConnection;
      pDBImportOrigem: IDBImportOrigem; pOutput: IOutput = nil;
      pProcessLog: IProcessLog = nil): IDBImport; override;
    function DBImportOrigemCreate: IDBImportOrigem; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj);
  end;

var
  ShopDBImportFormPLUBase: TShopDBImportFormPLUBase;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

{ TShopDBImportFormPLUBase }

constructor TShopDBImportFormPLUBase.Create(AOwner: TComponent;
  pAppObj: IAppObj);
begin
  inherited;
  FFileSelectFrame := TFileSelectLabeledEditFrame.Create(TopoPanel);
  PegueFormatoDe(FFileSelectFrame, MoldeFileSelectPanel);
end;

function TShopDBImportFormPLUBase.DBImportCreate(pDestinoDBConnection
  : IDBConnection; pDBImportOrigem: IDBImportOrigem; pOutput: IOutput = nil;
  pProcessLog: IProcessLog = nil): IDBImport;
begin

end;

function TShopDBImportFormPLUBase.DBImportOrigemCreate: IDBImportOrigem;
begin

end;

end.
