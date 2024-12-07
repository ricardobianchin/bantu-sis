unit ShopApp.Ger.GerForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.Ger.GerForm_u, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.StdCtrls,
  Vcl.ToolWin, Vcl.ComCtrls, App.AppObj, Sis.UI.Frame.Status.Thread_u,
  Sis.Threads.Factory_u, ShopApp.Threads.ShopAppSyncTermThreadCreator_u, Sis.Entities.Terminal;

type
  TGerShopAppForm = class(TGerAppForm)
  private
    { Private declarations }
    function FrameCreate(pTerminal: ITerminal): TThreadStatusFrame;
    function ShopAppSyncTermThreadCreatorCreate(pFrame: TThreadStatusFrame; pTerminal: ITerminal):TShopAppSyncTermThreadCreator;
  protected
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj); reintroduce;
  end;

var
  GerShopAppForm: TGerShopAppForm;

implementation

{$R *.dfm}

uses Sis.Threads.ThreadCreator, Sis.Threads.SafeBool;

{ TGerShopAppForm }

constructor TGerShopAppForm.Create(AOwner: TComponent; pAppObj: IAppObj);
var
  sNomeLocal: string;
begin
  inherited;
  sNomeLocal := AppObj.SisConfig.LocalMachineId.GetIdent;
  AppObj.TerminalList.ExecuteForAll(
    procedure(pTerminal: ITerminal)
    var
      oFrame: TThreadStatusFrame;
      oCreator: TShopAppSyncTermThreadCreator;
    begin
      oFrame := FrameCreate(pTerminal);
      oCreator := ShopAppSyncTermThreadCreatorCreate(oFrame, pTerminal);
      oFrame.ThreadCreator := oCreator;
    end, sNomeLocal);
end;

function TGerShopAppForm.FrameCreate(pTerminal: ITerminal): TThreadStatusFrame;
var
  sName: string;
begin
  // cria o Frame
  sName := 'ThreadStatusFrame' + (StatusFrameScrollBox.ControlCount + 1).ToString;
  Result := TThreadStatusFrame.Create(StatusFrameScrollBox);
  Result.Name := sName;
  Result.Parent := StatusFrameScrollBox;

  FramesList.Add(Result);
end;

function TGerShopAppForm.ShopAppSyncTermThreadCreatorCreate(
  pFrame: TThreadStatusFrame; pTerminal: ITerminal): TShopAppSyncTermThreadCreator;
begin
  // cria o creator
  Result := TShopAppSyncTermThreadCreator.Create( //
    pTerminal //
    , AppObj //
    //, pFrame.Executando //
    , pFrame.DoTerminate //
    , pTerminal.AsText
    );
end;

end.
