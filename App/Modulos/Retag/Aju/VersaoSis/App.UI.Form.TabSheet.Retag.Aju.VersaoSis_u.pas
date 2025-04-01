unit App.UI.Form.TabSheet.Retag.Aju.VersaoSis_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.StdCtrls, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Sis.Usuario, App.AppObj, Sis.DB.DBTypes,
  Vcl.OleCtrls, SHDocVw;

type
  TRetagAjuVersaoSisForm = class(TTabSheetAppBasForm)
    WebBrowser1: TWebBrowser;
  private
    { Private declarations }
    FPastaVersoes: string;
    procedure CarregarVersao;
  protected
    function GetTitulo: string; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
      pOutputNotify: IOutput; pAppObj: IAppObj); override;
  end;

var
  RetagAjuVersaoSisForm: TRetagAjuVersaoSisForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.RichEditUtils_u, Sis.Web.Utils_u;

{ TRetagAjuVersaoSisForm }

procedure TRetagAjuVersaoSisForm.CarregarVersao;
var
  sNomeArqAtual: string;
  oLinhasSL: TStringList;
  i: integer;
begin
  oLinhasSL := TStringList.Create;
  try
  //vai percorrer subpastas de FPastaVersoes
  //repete ate nao ter mais arquivos, e formar lista de versoes e nome de arquivo respectivo
  //ordenar em ordem de versao semantica da maior para a menor
  //cada arquivo desta, é colocado em sNomeArqAtual
  //carregado em um tstrings
  //inserido no richedit convertido formatado
    sNomeArqAtual := AppObj.AppInfo.Pasta + 'Inst\Update\VersoesSis\Recentes.html';
    sNomeArqAtual := Sis.Web.Utils_u.PathToUrl(sNomeArqAtual);

    WebBrowser1.Navigate(sNomeArqAtual);
  finally
    oLinhasSL.Free;
  end;

end;

constructor TRetagAjuVersaoSisForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pAppObj: IAppObj);
begin
  inherited;
  FPastaVersoes := appobj.appinfo.Pasta+'\Inst\Update\VersoesSis\';
  CarregarVersao;
end;

function TRetagAjuVersaoSisForm.GetTitulo: string;
begin
  Result := 'Versão do Sistema';
end;

end.
