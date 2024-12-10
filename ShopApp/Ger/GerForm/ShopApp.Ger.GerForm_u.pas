unit ShopApp.Ger.GerForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.Ger.GerForm_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.StdCtrls,
  Vcl.ToolWin, Vcl.ComCtrls, App.AppObj, Sis.Entities.Terminal, Sis.DB.DBTypes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client;

type
  TGerShopAppForm = class(TGerAppForm)
  private
    { Private declarations }
  protected
    procedure PreenchaTarefaList; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj); reintroduce;
  end;

var
  GerShopAppForm: TGerShopAppForm;

implementation

{$R *.dfm}

uses Sis.Threads.SafeBool, Sis.Threads.Tarefa, App.DB.Utils, Sis.Sis.Constants,
  ShopApp.Threads.ShopAppSyncTermThread.Factory_u, Sis.Threads.Factory_u,
  Sis.UI.Frame.Status.Thread_u, Sis.Threads.ThreadBas_u,
  ShopApp.Threads.ShopAppSyncTermTarefa_u;

{ TGerShopAppForm }

constructor TGerShopAppForm.Create(AOwner: TComponent; pAppObj: IAppObj);
begin
  inherited;
end;

procedure TGerShopAppForm.PreenchaTarefaList;
var
  oTarefa: ITarefa;
  sNomeLocal: string;
begin
  inherited;
  sNomeLocal := AppObj.SisConfig.LocalMachineId.GetIdent;
  AppObj.TerminalList.ExecuteForAll(
    //
    procedure(pTerminal: ITerminal)
    var
      oFrame: TThreadStatusFrame;
      oTarefa: ITarefa;
      rServDBConnectionParams: TDBConnectionParams;
      rTermDBConnectionParams: TDBConnectionParams;
    begin
      oFrame := ThreadFrameCreate(StatusFrameScrollBox);
      oFrame.TitLabel.Caption := 'Enviar para ' + pTerminal.AsText;
      oFrame.StatusLabel.Caption := '';

      rServDBConnectionParams := TerminalIdToDBConnectionParams
        (TERMINAL_ID_RETAGUARDA, AppObj);

      rTermDBConnectionParams.Server := pTerminal.IdentStr;
      rTermDBConnectionParams.Arq := pTerminal.LocalArqDados;
      rTermDBConnectionParams.Database := pTerminal.Database;

      oTarefa := TShopAppSyncTermTarefa.Create(rServDBConnectionParams,
        rTermDBConnectionParams, pTerminal, AppObj, oFrame);
      TarefaList.Add(oTarefa);
    end
  //
    , sNomeLocal);

  {

    sNomeLocal: string;
    begin
    inherited;
    sNomeLocal := AppObj.SisConfig.LocalMachineId.GetIdent;

    // para cada terminal, cria frames
    AppObj.TerminalList.ExecuteForAll(
    procedure(pTerminal: ITerminal)
    var
    oFrame: TThreadStatusFrame;
    oCreator: TShopAppSyncTermThreadCreator;
    begin
    oFrame := FrameCreate(pTerminal);
    oCreator := nil;
    ShopAppSyncTermThreadCreatorCreate(pTerminal, AppObj, oFrame.TitOutput,
    oFrame.StatusOutput, oFrame.ProcessLog, '');
    end, sNomeLocal);

  }

end;

end.
