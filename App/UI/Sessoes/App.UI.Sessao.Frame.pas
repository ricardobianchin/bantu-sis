unit App.UI.Sessao.Frame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, App.UI.Form.Bas.Modulo_u,
  Sis.ModuloSistema.Types, Sis.Usuario, App.Sessao, App.Sessao.EventosDeSessao,
  Sis.UI.Form.LoginPerg_u, Sis.UI.Form.Login.Config, Sis.DB.DBTypes, App.Constants,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

type
  TSessaoFrame = class(TFrame, ISessao)
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
    FModuloBasForm: TModuloBasForm;
    FTipoOpcaoSisModulo: TOpcaoSisIdModulo;
    FUsuario: IUsuario;
    FIndex: TSessaoIndex;
    FEventosDeSessao: IEventosDeSessao;
    FDBMS: IDBMS;
    FOutput: IOutput;
    FProcessLog: IProcessLog;

//    FLoginConfig: ILoginConfig;

    function GetModuloBasForm: TModuloBasForm;
    function GetUsuario: IUsuario;
    function GetIndex: TSessaoIndex;

  protected
  public
    { Public declarations }

    property ModuloBasForm: TModuloBasForm read GetModuloBasForm;
    property Index: TSessaoIndex read GetIndex;
    property Usuario: IUsuario read GetUsuario;
    procedure EscondaModuloForm;
    property DBMS: IDBMS read FDBMS;
    property Output: IOutput read FOutput;
    property ProcessLog: IProcessLog read FProcessLog;

    constructor Create(AOwner: TComponent;
      pTipoOpcaoSisModulo: TOpcaoSisIdModulo; pUsuario: IUsuario;
      pModuloBasForm: TModuloBasForm; pIndex: TSessaoIndex;
      pEventosDeSessao: IEventosDeSessao; pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog
      //; pLoginConfig: ILoginConfig
      ); reintroduce;
  end;

implementation

{$R *.dfm}

uses App.DB.Utils, Sis.DB.Factory;

{ TSessaoFrame }

procedure TSessaoFrame.AbrirActionExecute(Sender: TObject);
begin
  FEventosDeSessao.DoAbrirSessao(Index)
end;

constructor TSessaoFrame.Create(AOwner: TComponent;
  pTipoOpcaoSisModulo: TOpcaoSisIdModulo; pUsuario: IUsuario;
  pModuloBasForm: TModuloBasForm; pIndex: TSessaoIndex;
  pEventosDeSessao: IEventosDeSessao; pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog
  {; pLoginConfig: ILoginConfig}
  );
var
  s: string;
begin
  inherited Create(AOwner);
  FModuloBasForm := pModuloBasForm;
  FTipoOpcaoSisModulo := pTipoOpcaoSisModulo;
  FUsuario := pUsuario;
  FIndex := pIndex;
  FEventosDeSessao := pEventosDeSessao;
  FDBMS := pDBMS;
  FOutput := pOutput;
  FProcessLog := pProcessLog;

//  FLoginConfig := pLoginConfig;

  s := FUsuario.NomeExib;
  ApelidoLabel.Caption := s;

  s := TipoOpcaoSisModuloToStr(FTipoOpcaoSisModulo);
  ModuloLabel.Caption := s;
end;

procedure TSessaoFrame.EscondaModuloForm;
begin
  if not ModuloBasForm.Visible then
    exit;

  ModuloBasForm.Hide;
end;

function TSessaoFrame.GetIndex: TSessaoIndex;
begin
  Result := FIndex;
end;

function TSessaoFrame.GetModuloBasForm: TModuloBasForm;
begin
  Result := FModuloBasForm;
end;

function TSessaoFrame.GetUsuario: IUsuario;
begin
  Result := FUsuario;
end;

end.
