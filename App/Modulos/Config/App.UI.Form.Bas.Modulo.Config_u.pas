unit App.UI.Form.Bas.Modulo.Config_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Modulo_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Menus, Sis.UI.FormCreator,
  Sis.DB.DBTypes, App.DB.Utils, Sis.DB.Factory, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output, Sis.ModuloSistema, App.Sessao.EventosDeSessao,
  App.Constants,
  Sis.Usuario, App.AppObj, Sis.UI.Controls.Utils, App.DB.Import.Form_u,
  Sis.Types.Contador, Sis.Entities.Types;

type
  TConfigModuloBasForm = class(TModuloBasForm)
    ConfigActionList: TActionList;
    ConfigDBImportAbrirAction: TAction;
    ConfigAmbiLojasAction: TAction;
    ConfigTerminaisAction: TAction;
    BalloonHint1: TBalloonHint;
  private
    { Private declarations }
  protected
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pModuloSistema: IModuloSistema;
      pEventosDeSessao: IEventosDeSessao; pSessaoIndex: TSessaoIndex;
      pUsuario: IUsuario; pAppObj: IAppObj; pTerminalId: TTerminalId);
  end;

var
  ConfigModuloBasForm: TConfigModuloBasForm;

implementation

{$R *.dfm}

uses Sis.Types.Factory, Sis.UI.IO.Factory, App.AppInfo, Sis.Config.SisConfig,
  App.Pess.UI.Factory_u, App.Config.Ambi.Factory_u;

{ TConfigModuloBasForm }

constructor TConfigModuloBasForm.Create(AOwner: TComponent;
  pModuloSistema: IModuloSistema; pEventosDeSessao: IEventosDeSessao;
  pSessaoIndex: TSessaoIndex; pUsuario: IUsuario; pAppObj: IAppObj;
  pTerminalId: TTerminalId);
begin
  inherited Create(AOwner, pModuloSistema, pEventosDeSessao, pSessaoIndex,
    pUsuario, pAppObj, pTerminalId);
end;

procedure TConfigModuloBasForm.DBImportPrep;
begin
end;

procedure TConfigModuloBasForm.TabSheetCrie(pFormCreator: IFormCreator);
begin
end;

end.
