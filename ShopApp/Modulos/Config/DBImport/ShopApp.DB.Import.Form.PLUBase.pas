unit ShopApp.DB.Import.Form.PLUBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.DB.Import.Form_u, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, App.AppObj, System.Actions, Vcl.ActnList, Vcl.Buttons,
  Sis.UI.IO.Output, Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.Controls.Files.FileSelectLabeledEdit.Frame;

type
  TShopDBImportFormPLUBase = class(TDBImportForm)
    MoldeFileSelectPanel: TPanel;
    procedure ExecuteAction_AppDBImportExecute(Sender: TObject);
  private
    { Private declarations }
    FNomeArq: string;
    FFileSelectFrame: TFileSelectLabeledEditFrame;
  protected
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj;
      pProcessLog: IProcessLog = nil);
  end;

var
  ShopDBImportFormPLUBase: TShopDBImportFormPLUBase;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

{ TShopDBImportFormPLUBase }

constructor TShopDBImportFormPLUBase.Create(AOwner: TComponent;
  pAppObj: IAppObj; pProcessLog: IProcessLog = nil);
begin
  inherited;
  FFileSelectFrame := TFileSelectLabeledEditFrame.Create(TopoPanel);
  PegueFormatoDe(FFileSelectFrame, MoldeFileSelectPanel);
end;

procedure TShopDBImportFormPLUBase.ExecuteAction_AppDBImportExecute
  (Sender: TObject);
var
  bResultado: boolean;
begin
  inherited;
  StatusOutput.Exibir('Inicio');
  try
    FNomeArq := FFileSelectFrame.NomeArq;
    bResultado := FileExists(FNomeArq);
    if not bResultado then
    begin
      StatusOutput.ExibirPausa('Erro: Arquivo nao existe: [' + FNomeArq + ']', TMsgDlgType.mtError);
      Exit;
    end;
  finally
    StatusOutput.Exibir('Fim');
    StatusOutput.Exibir('');
  end;
end;

end.
