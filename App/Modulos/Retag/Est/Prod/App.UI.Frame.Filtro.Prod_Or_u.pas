unit App.UI.Frame.Filtro.Prod_Or_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas.Filtro_u, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  System.Generics.Collections, Vcl.ComCtrls, Vcl.ToolWin;

type
  TProdOrFiltroFrame = class(TFiltroFrame)
    FundoPanel: TPanel;
    FiltroStringLabeledEdit: TLabeledEdit;
    CodRadioButton: TRadioButton;
    BarrasRadioButton: TRadioButton;
    DescrRadioButton: TRadioButton;
    FabrRadioButton: TRadioButton;
    TipoRadioButton: TRadioButton;
    ErroLabel: TLabel;
    TitPanel: TPanel;
    TitLabel: TLabel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    procedure FiltroStringLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure FiltroStringLabeledEditChange(Sender: TObject);
  private
    { Private declarations }
    FRadioButtonList: TList<TRadioButton>;
    procedure RadioButtonClick(Sender: TObject);
  protected
    function GetValues: variant; override;
    procedure SetValues(Value: variant); override;
    function NewArrayCreate: variant; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pOnChange: TNotifyEvent); override;
    destructor Destroy; override;

  end;

var
  ProdOrFiltroFrame: TProdOrFiltroFrame;

implementation

{$R *.dfm}

uses Sis.Types.strings_u, Sis.UI.ImgDM;

{ TProdFiltroFrame }

procedure TProdOrFiltroFrame.RadioButtonClick(Sender: TObject);
begin
  DoChange;
end;

constructor TProdOrFiltroFrame.Create(AOwner: TComponent;
  pOnChange: TNotifyEvent);
var
  R: TRadioButton;
  i: Integer;
  iRadioLeft: Integer;
begin
  inherited;
  FRadioButtonList := TList<TRadioButton>.Create;

  FRadioButtonList.Add(CodRadioButton);
  FRadioButtonList.Add(BarrasRadioButton);
  FRadioButtonList.Add(DescrRadioButton);
  FRadioButtonList.Add(FabrRadioButton);
  FRadioButtonList.Add(TipoRadioButton);

  iRadioLeft := FiltroStringLabeledEdit.left + FiltroStringLabeledEdit.Width + 6;
  for i := 0 to FRadioButtonList.Count -1 do
  begin
    R := FRadioButtonList[i];
    R.Left := iRadioLeft + i * 90;
    R.Top := FiltroStringLabeledEdit.Top + 3;
    R.onclick := RadioButtonClick;
  end;
end;

destructor TProdOrFiltroFrame.Destroy;
begin
  FRadioButtonList.Free;
  inherited;
end;

procedure TProdOrFiltroFrame.FiltroStringLabeledEditChange(Sender: TObject);
begin
  inherited;
  AgendeChange;
end;

procedure TProdOrFiltroFrame.FiltroStringLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key = #13 then
  begin
    key := #0;
    DoChange;
  end;
  CharSemAcento(Key);
end;

function TProdOrFiltroFrame.GetValues: variant;
var
  R: TRadioButton;
  i: Integer;
  sFiltro: string;
  bCod: boolean;
  bSoDig: Boolean;
  sErro: string;
  bErroCod: Boolean;
begin
  Result := inherited;

  bCod := CodRadioButton.Checked or BarrasRadioButton.Checked;
  sFiltro := FiltroStringLabeledEdit.Text;
  sErro := '';
  bErroCod := False;

  if bCod then
  begin
    bSoDig := StrIsOnlyDigit(sFiltro);
    if not bSoDig then
    begin
      bErroCod := True;
      sErro := 'Filtro por código só pode ter algarismos';
      sFiltro := '';
    end;
  end;

  if ErroLabel.Caption <> sErro then
  begin
    ErroLabel.Caption := sErro;
  end;

  Result[0] := sFiltro;

  for i := 0 to FRadioButtonList.Count -1 do
  begin
    R := FRadioButtonList[i];
    Result[i+1] := R.Checked;
  end;

  if bErroCod then
  begin
    Result[0] := False;
    Result[1] := False;
    Result[2] := True;
  end;
end;

function TProdOrFiltroFrame.NewArrayCreate: variant;
begin
  Result := VarArrayCreate([0, 5], varVariant);
end;

procedure TProdOrFiltroFrame.SetValues(Value: variant);
var
  R: TRadioButton;
  i: Integer;
begin
  if VarArrayDimCount(Value) < 6 then
    exit;

  FiltroStringLabeledEdit.Text := VarToStr(Value[0]);

  for i := 0 to FRadioButtonList.Count -1 do
  begin
    R := FRadioButtonList[i];
    R.Checked := Value[i+1];
  end;

  AjusteValores;
end;

end.
