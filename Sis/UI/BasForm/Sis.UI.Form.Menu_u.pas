unit Sis.UI.Form.Menu_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Diag_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, System.Generics.Collections, Sis.UI.Controls.BotaoFrame_u;

type
  TOpcaoRecord = record
    Action: TAction;
    ShortCuts: TArray<TShortCut>;
  end;

  TMenuForm = class(TDiagBasForm)
    FundoPanel_AppMenuForm: TPanel;
    BotoesPanel: TPanel;
  private const
    BUTTON_WIDTH = 110;
    BUTTON_ROW_HEIGHT = 74;
    STARTING_TOP = 10;
    STARTING_LEFT = 10;
  private
    { Private declarations }
    FCurrentTop: integer;
    FCurrentLeft: integer;
    FBotoes: TList<TOpcaoRecord>;
    FActionEscolhida: TAction;
    procedure DoBotaoClick(Sender: TObject);
  public
    { Public declarations }
    procedure NovaLinha;
    procedure PegarAction(pAction: TAction; pShortCuts: TArray<TShortCut>);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Perg(out pActionEscolhida: tAction): Boolean;
    property ActionEscolhida: TAction read FActionEscolhida write FActionEscolhida;
  end;

var
  MenuForm: TMenuForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.UI.Controls.Factory;

{ TMenuForm }

constructor TMenuForm.Create(AOwner: TComponent);
begin
  inherited;
  FBotoes := TList<TOpcaoRecord>.Create;
  ActionEscolhida := nil;
  FCurrentTop := STARTING_TOP;
  FCurrentLeft := STARTING_LEFT;
end;

destructor TMenuForm.Destroy;
begin
  FBotoes.Free;
  inherited;
end;

procedure TMenuForm.DoBotaoClick(Sender: TObject);
var
  oControl: TControl;
begin
  oControl :=TControl(Sender);
  while oControl.ClassName <> 'TBotaoFrame' do
  begin
    oControl := oControl.Parent;
  end;

  ActionEscolhida := FBotoes[oControl.Tag].Action;
  OkAct_Diag.Execute;
end;

procedure TMenuForm.NovaLinha;
begin
  FCurrentLeft := STARTING_LEFT;
  inc(FCurrentTop, BUTTON_ROW_HEIGHT + 3);
end;

procedure TMenuForm.PegarAction(pAction: TAction; pShortCuts: TArray<TShortCut>);
var
  b: TBotaoFrame;
  o: TOpcaoRecord;
  iProximoLeft: integer;
  iTag: NativeInt;
begin
  iProximoLeft := FCurrentLeft + BUTTON_WIDTH + 5;
  if iProximoLeft > BotoesPanel.ClientRect.Width then
  begin
    NovaLinha;
    iProximoLeft := FCurrentLeft + BUTTON_WIDTH + 5;
  end;

  iTag := FBotoes.Count;
  b := BotaoFrameCreate(BotoesPanel, pAction.Caption, '', FCurrentLeft, FCurrentTop,
    DoBotaoClick, pAction.Images, pAction.ImageIndex , iTag);

  o.Action := pAction;
  o.ShortCuts := pShortCuts;
  FBotoes.Add(o);
  FCurrentLeft := iProximoLeft;
end;

function TMenuForm.Perg(out pActionEscolhida: tAction): Boolean;
begin
  Result := inherited Perg;
  if Result then
    pActionEscolhida := FActionEscolhida;
end;

end.
