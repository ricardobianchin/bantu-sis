unit App.UI.Form.Bas.Modulo.PDV_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus, App.PDV.AppPDVObj,
  Sis.ModuloSistema, App.Sessao.Eventos, App.Constants, Sis.Usuario,
  Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppObj,
  Sis.Entities.Types, Sis.Entities.Terminal, App.PDV.Factory_u;

type
  TPDVModuloBasForm = class(TModuloBasForm)
    N1: TMenuItem;
    ConsultaPreo1: TMenuItem;
    PDVActionList: TActionList;
    PrecoBuscaAction_PDVModuloBasForm: TAction;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FAppPDVObj: IAppPDVObj;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pSessaoEventos: ISessaoEventos; pSessaoIndex: TSessaoIndex;
      pLogUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId);
      reintroduce; virtual;
  end;

var
  PDVModuloBasForm: TPDVModuloBasForm;

implementation

{$R *.dfm}

constructor TPDVModuloBasForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pSessaoEventos: ISessaoEventos;
  pSessaoIndex: TSessaoIndex; pLogUsuario: IUsuario; pAppObj: IAppObj;
  pTerminalId: TTerminalId);
begin
  inherited;
  FAppPDVObj := AppPDVObjCreate(LogUsuario.LojaId, Terminal.TerminalId, 0);
end;

procedure TPDVModuloBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;

  //
end;

end.
