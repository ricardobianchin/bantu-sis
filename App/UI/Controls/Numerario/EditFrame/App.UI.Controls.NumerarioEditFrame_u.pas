unit App.UI.Controls.NumerarioEditFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, NumEditBtu, Sis.UI.Controls.WinControlsNavigator,
  Sis.Sis.Atualizavel;

type
  TNumerarioEditFrame = class(TBasFrame)
    Image1: TImage;
    Label2: TLabel;
    ResultadoLabel: TLabel;
  private
    { Private declarations }
    FQtdNumEdit: TNumEditBtu;
    FNumerarioValor: Currency;
    FWinControlsNavigator: IWinControlsNavigator;
    FAtualizavel: IAtualizavel;

    function GetQtd: SmallInt;
    procedure SetQtd(const Value: SmallInt);

    function GetValor: Currency;

    procedure EditChange(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    { Public declarations }
    property Qtd: SmallInt read GetQtd write SetQtd;
    property Valor: Currency read GetValor;

    constructor Create(AOwner: TComponent; pNumerarioValor: Currency;
      pPastaImagens: string; pWinControlsNavigator: IWinControlsNavigator; pAtualizavel: IAtualizavel);
      reintroduce;
  end;

  // var
  // NumerarioEditFrame: TNumerarioEditFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.Types.Floats, Sis.Types.strings_u;

{ TNumerarioEditFrame }

constructor TNumerarioEditFrame.Create(AOwner: TComponent;
  pNumerarioValor: Currency; pPastaImagens: string;
  pWinControlsNavigator: IWinControlsNavigator; pAtualizavel: IAtualizavel);
var
  sFormat: string;
  sNomeArq: string;
  sNomeCompleto: string;
  sName: string;
begin
  inherited Create(AOwner);
  FNumerarioValor := pNumerarioValor;
  FWinControlsNavigator := pWinControlsNavigator;
  FAtualizavel := pAtualizavel;

  sName := FormatFloat('000000.0000', pNumerarioValor);
  sName := StrToName(sName);
  sName := ClassName + sName;
  Name := sName;
  // ClearStyleElements(Self);

  FQtdNumEdit := TNumEditBtu.Create(Self);
  FQtdNumEdit.Parent := Self;
  FQtdNumEdit.Alignment := taCenter;
  FQtdNumEdit.NCasas := 0;
  FQtdNumEdit.NCasasEsq := 3;
  FQtdNumEdit.Caption := DinheiroStr(FNumerarioValor) + ' X';
  FQtdNumEdit.LabelPosition := lpLeft;
  FQtdNumEdit.LabelSpacing := 5;

  FQtdNumEdit.Left := 169;
  FQtdNumEdit.Top := 2;
  FQtdNumEdit.Width := 54;

  FQtdNumEdit.OnChange := EditChange;

  pPastaImagens := IncludeTrailingPathDelimiter(pPastaImagens);

  sFormat := 'numerario_%g.jpg';
  sNomeArq := Format(sFormat, [FNumerarioValor]);
  sNomeCompleto := pPastaImagens + sNomeArq;
  Image1.Picture.LoadFromFile(sNomeCompleto);
  Image1.Hint := ValorPorExtenso(FNumerarioValor);
end;

procedure TNumerarioEditFrame.EditChange(Sender: TObject);
begin
  ResultadoLabel.Caption := DinheiroStr(Valor);
  FAtualizavel.Atualize;
end;

procedure TNumerarioEditFrame.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_UP:
      begin
        FWinControlsNavigator.SelecioneAnterior;
      end;
    VK_DOWN, VK_RETURN:
      begin
        FWinControlsNavigator.SelecioneProximo;
      end;
    VK_PRIOR:
      begin
        FWinControlsNavigator.SelecionePrimeiro;
      end;
  end;
end;

procedure TNumerarioEditFrame.EditKeyPress(Sender: TObject; var Key: Char);
var
  q: SmallInt;
begin
  case Key of
    '-':
      begin
        key := #0;
        q := Qtd;
        if q > 0 then
        begin
          Dec(q);
          Qtd := q;
        end;
      end;
    '+':
      begin
        key := #0;
        q := Qtd;
        if q < 999 then
        begin
          Inc(q);
          Qtd := q;
        end;
      end;
  end;
end;

function TNumerarioEditFrame.GetQtd: SmallInt;
begin
  Result := FQtdNumEdit.AsInteger;
end;

function TNumerarioEditFrame.GetValor: Currency;
begin
  Result := FNumerarioValor * GetQtd;
end;

procedure TNumerarioEditFrame.SetQtd(const Value: SmallInt);
begin
  FQtdNumEdit.Valor := Value;
end;

end.
