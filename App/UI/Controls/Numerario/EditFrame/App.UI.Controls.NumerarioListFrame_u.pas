unit App.UI.Controls.NumerarioListFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, App.Est.Venda.Caixa.CxValor.DBI, Data.DB, Sis.DB.DBTypes,
  App.UI.Controls.NumerarioEditFrame_u, System.Generics.Collections,
  Sis.UI.Controls.WinControlsNavigator, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Sis.Sis.Atualizavel_u, Sis.Types.Floats;

type
  TNumerarioListFrame = class(TBasFrame, IWinControlsNavigator, IAtualizavel)
    BasePanel: TPanel;
    NumerarioTotLabeledEdit: TLabeledEdit;
  private
    { Private declarations }
    FEditFrameList: TLIst<TNumerarioEditFrame>;
    FCxValorDBI: ICxValorDBI;
    FPastaImagens: string;
    procedure LeRegCrieEditFrame(q: TDataSet; pRecNo: integer);

    procedure EditKeyDownUltimo(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Atualize;
    function GetNumerarioTotal: Currency;
  public
    procedure SelecionePrimeiro;
    procedure SelecioneAnterior;
    procedure SelecioneProximo;
    procedure SelecioneUltimo;
    { Public declarations }
    constructor Create(AOwner: TComponent; pCxValorDBI: ICxValorDBI;
      pPastaImagens: string); reintroduce;
    destructor Destroy; override;
  end;

  // var
  // NumerarioListFrame: TNumerarioListFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.Types.Utils_u;

{ TNumerarioListFrame }

procedure TNumerarioListFrame.Atualize;
var
  uTot: Currency;
begin
  uTot := GetNumerarioTotal;
  NumerarioTotLabeledEdit.Text := DinhToStr(uTot);
end;

constructor TNumerarioListFrame.Create(AOwner: TComponent;
  pCxValorDBI: ICxValorDBI; pPastaImagens: string);
begin
  inherited Create(AOwner);
  FCxValorDBI := pCxValorDBI;
  FPastaImagens := pPastaImagens;
  FEditFrameList := TList<TNumerarioEditFrame>.Create;
  FCxValorDBI.ForEach(vaNull, LeRegCrieEditFrame);
  ReadOnlySet(NumerarioTotLabeledEdit);
  Atualize;
end;

destructor TNumerarioListFrame.Destroy;
begin
  FEditFrameList.Free;
  inherited;
end;

procedure TNumerarioListFrame.EditKeyDownUltimo(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

function TNumerarioListFrame.GetNumerarioTotal: Currency;
begin
  Result := ZERO_CURRENCY;
  for var oFrame: TNumerarioEditFrame in FEditFrameList do
    Result := Result + oFrame.Valor;
end;

procedure TNumerarioListFrame.LeRegCrieEditFrame(q: TDataSet; pRecNo: integer);
var
  oFrame: TNumerarioEditFrame;
begin
  if pRecNo < 1 then
    exit;

  oFrame := TNumerarioEditFrame.Create(Self, q.Fields[0].AsCurrency,
    FPastaImagens, Self, Self);
  oFrame.Left := 0;
  oFrame.Top := (pRecNo - 1) * oFrame.Height;
  FEditFrameList.Add(oFrame);
end;

procedure TNumerarioListFrame.SelecioneAnterior;
begin
  SelectNext(nil, True, True);
end;

procedure TNumerarioListFrame.SelecionePrimeiro;
begin
  SelectFirst;
end;

procedure TNumerarioListFrame.SelecioneProximo;
begin
  SelectNext(nil, False, True);
end;

procedure TNumerarioListFrame.SelecioneUltimo;
begin

end;

end.
