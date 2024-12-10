unit ShopApp.Ger.GerForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.Ger.GerForm_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.StdCtrls,
  Vcl.ToolWin, Vcl.ComCtrls, App.AppObj,
  Sis.Entities.Terminal;

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

uses Sis.Threads.ThreadCreator, Sis.Threads.SafeBool, Sis.Threads.Tarefa,
  ShopApp.Threads.ShopAppSyncTermThread.Factory_u, Sis.Threads.Factory_u,
  Sis.UI.Frame.Status.Thread_u, Sis.Threads.ThreadBas_u;

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
      oCreator: IThreadCreator;
      oTarefa: ITarefa;
    begin
      oFrame := ThreadFrameCreate(StatusFrameScrollBox);
      oCreator := ShopAppSyncTermThreadCreatorCreate(pTerminal, AppObj,
        oFrame.TitOutput, oFrame.StatusOutput, oFrame.ProcessLog);
      oTarefa := TarefaCreate(oFrame, oCreator);
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
