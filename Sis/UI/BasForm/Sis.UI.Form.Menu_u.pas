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
    ShortCuts: TArray<TShortCut>; //   TShortCut = Low(Word)..High(Word);
  end;

  TMenuForm = class(TDiagBasForm)
    FundoPanel_AppMenuForm: TPanel;
    BotoesPanel: TPanel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
    function KeyToAction(var Key: Word): TAction;
    function TemShortCut(pShortCut: word; ShortCuts: TArray<TShortCut>): Boolean;
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

uses Sis.UI.Controls.Utils, Sis.UI.Controls.Factory, Sis.Types.strings_u;

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

procedure TMenuForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  a: TAction;
begin
  inherited;
  a := KeyToAction(key);
  if a = nil then
    exit;

  a.Execute;
  Close;
end;

procedure TMenuForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #27 then
  begin
    CancelAct_Diag.Execute;
  end;
end;

function TMenuForm.KeyToAction(var Key: Word): TAction;
begin
  Result := nil;
  for var o: TOpcaoRecord in FBotoes do
  begin
    if TemShortCut(Key, o.ShortCuts) then
    begin
      Result := o.Action;
      Break;
    end;
  end;
end;

procedure TMenuForm.NovaLinha;
begin
  FCurrentLeft := STARTING_LEFT;
  inc(FCurrentTop, BUTTON_ROW_HEIGHT + 3);
end;

procedure TMenuForm.PegarAction(pAction: TAction; pShortCuts: TArray<TShortCut>);
var
  //b: TBotaoFrame;
  o: TOpcaoRecord;
  iProximoLeft: integer;
  iTag: NativeInt;
  sCap: string;
begin
  iProximoLeft := FCurrentLeft + BUTTON_WIDTH + 5;
  if iProximoLeft > BotoesPanel.ClientRect.Width then
  begin
    NovaLinha;
    iProximoLeft := FCurrentLeft + BUTTON_WIDTH + 5;
  end;

  iTag := FBotoes.Count;
  sCap := pAction.Caption;
  if Length(pShortCuts) > 0 then
  begin
    sCap := KeyToStr(pShortCuts[0]) + ' - '+ sCap;
  end;

  {b := }BotaoFrameCreate(BotoesPanel, sCap, '', FCurrentLeft, FCurrentTop,
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

function TMenuForm.TemShortCut(pShortCut: word;
  ShortCuts: TArray<TShortCut>): Boolean;
begin
  Result := False;
  for var ShortCut in ShortCuts do
  begin
    if ShortCut = pShortCut then
    begin
      Result := true;
      break;
    end;
  end;
end;

end.
