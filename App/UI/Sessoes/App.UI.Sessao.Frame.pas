unit App.UI.Sessao.Frame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  App.UI.Form.Bas.Modulo_u, Sis.ModuloSistema.Types, Sis.Usuario, App.Sessao,
  App.Sessao.EventosDeSessao, Sis.UI.Form.LoginPerg_u, Sis.UI.Form.Login.Config,
  Sis.DB.DBTypes, App.Constants, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.Entities.Types;

type
  TSessaoFrame = class(TFrame)
    FundoPanel: TPanel;
    ApelidoLabel: TLabel;
    ModuloLabel: TLabel;
    AbrirButton: TButton;
    ActionList1: TActionList;
    AbrirAction: TAction;
    ApelidoTitLabel: TLabel;
    ModuloTitLabel: TLabel;
    procedure AbrirActionExecute(Sender: TObject);
  private
    { Private declarations }
    FEventosDeSessao: IEventosDeSessao;
    FDBMS: IDBMS;
    FOutput: IOutput;
    FProcessLog: IProcessLog;
    FSessao: ISessao;

  protected
  public
    { Public declarations }

    property DBMS: IDBMS read FDBMS;
    property Output: IOutput read FOutput;
    property ProcessLog: IProcessLog read FProcessLog;
    property Sessao: ISessao read FSessao;

    constructor Create(AOwner: TComponent;
      pTipoOpcaoSisModulo: TOpcaoSisIdModulo; pUsuario: IUsuario;
      pModuloBasForm: TModuloBasForm; pIndex: TSessaoIndex;
      pTerminalId: TTerminalId; pEventosDeSessao: IEventosDeSessao;
      pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog
      ); reintroduce;
  end;

implementation

{$R *.dfm}

uses App.DB.Utils, Sis.DB.Factory, App.Sessao.Factory, Sis.UI.Controls.Utils;

{ TSessaoFrame }

procedure TSessaoFrame.AbrirActionExecute(Sender: TObject);
begin
  FEventosDeSessao.DoAbrirSessao(Sessao.Index)
end;

constructor TSessaoFrame.Create(AOwner: TComponent;
  pTipoOpcaoSisModulo: TOpcaoSisIdModulo; pUsuario: IUsuario;
  pModuloBasForm: TModuloBasForm; pIndex: TSessaoIndex;
  pTerminalId: TTerminalId; pEventosDeSessao: IEventosDeSessao; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog
  );
var
  s: string;
begin
  inherited Create(AOwner);
  FSessao := SessaoCreate(pTipoOpcaoSisModulo, pUsuario,
    pModuloBasForm, pIndex, pTerminalId);

  FEventosDeSessao := pEventosDeSessao;
  FDBMS := pDBMS;
  FOutput := pOutput;
  FProcessLog := pProcessLog;

  // FLoginConfig := pLoginConfig;

  s := Sessao.Usuario.NomeExib;
  ApelidoLabel.Caption := s;

  s := TipoOpcaoSisModuloToStr(Sessao.TipoOpcaoSisModulo);
  ModuloLabel.Caption := s;

  Sis.UI.Controls.Utils.SetOnClickToChilds(Self, AbrirActionExecute);
  Sis.UI.Controls.Utils.SetCursorToChilds(Self, crHandPoint);
end;

end.
