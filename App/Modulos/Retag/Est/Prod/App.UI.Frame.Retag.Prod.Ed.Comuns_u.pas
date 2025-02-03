unit App.UI.Frame.Retag.Prod.Ed.Comuns_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Frame.Bas.Retag.Prod.Ed_u,
  App.Retag.Est.Prod.Ent, Vcl.Mask, Sis.UI.IO.Output, NumEditBtu,
  Sis.UI.Controls.ComboBoxManager, App.Ent.DBI, App.Retag.Est.Prod.ComboBox_u,
  Sis.DB.DBTypes, System.Generics.Collections, Sis.UI.FormCreator,
  App.Retag.Est.Prod.Barras.Frame_u, App.AppObj, sndkey32, Data.DB, Sis.Types
  //
    , App.Retag.Est.Prod.Fabr.Ent //
    , App.Retag.Est.Prod.Tipo.Ent //
    , App.Retag.Est.Prod.Unid.Ent //
    , App.Retag.Est.Prod.ICMS.Ent //
    , App.Est.Prod.Barras.DBI

  //
    , Vcl.NumberBox, Vcl.StdCtrls, Vcl.ExtCtrls //
  //
    ;

type
  TRetagProdEdComunsFrame = class(TRetagProdEdBasFrame)
    DescrEdit: TLabeledEdit;
    DescrRedEdit: TLabeledEdit;
    CustoGroupBox: TGroupBox;
    PrecoGroupBox: TGroupBox;
    BalGroupBox: TGroupBox;
    BalTextoEtiqTitLabel: TLabel;
    BalTextoEtiqMemo: TMemo;
    MoldeCapacEmbLabeledEdit: TLabeledEdit;
    AtivoCheckBox: TCheckBox;
    MoldeBalDptoLabeledEdit: TLabeledEdit;
    MoldeBalValidEditLabeledEdit: TLabeledEdit;
    DescrErroLabel: TLabel;
    DescrRedErroLabel: TLabel;
    GeraBarrasLabel: TLabel;
    MoldeMargemLabeledEdit: TLabeledEdit;
    CustoErroLabel: TLabel;
    PrecoErroLabel: TLabel;
    LocalizLabeledEdit: TLabeledEdit;
    NcmLabeledEdit: TLabeledEdit;
    BalancaExigeCheckBox: TCheckBox;
    procedure DescrEditChange(Sender: TObject);
    procedure DescrRedEditChange(Sender: TObject);
    procedure AtivoCheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure GeraBarrasLabelClick(Sender: TObject);
  private
    { Private declarations }

    FWinControlList: TList<Vcl.Controls.TWinControl>;

    FFabrDataSetFormCreator: IFormCreator;
    FProdTipoDataSetFormCreator: IFormCreator;
    FProdUnidDataSetFormCreator: IFormCreator;
    FProdICMSDataSetFormCreator: IFormCreator;

    FAppObj: IAppObj;

    SelecioneProximoProc: TProcedureOfObject;
  public
    { Public declarations }

    IdEdit: TNumEditBtu;
    BarrasFr: TProdBarrasFrame;

    CustoAtuEdit: TNumEditBtu;
    CustoNovEdit: TNumEditBtu;

    // FMargemNumEdit: TNumEditBtu;

    PrecoAtuEdit: TNumEditBtu;
    PrecoSugEdit: TNumEditBtu;
    PrecoNovEdit: TNumEditBtu;

    BalDpto: TNumEditBtu;
    BalValidEdit: TNumEditBtu;
    CapacEmbEdit: TNumEditBtu;
    MargemEdit: TNumEditBtu;

    FabrFr: TComboBoxProdEdFrame;
    TipoFr: TComboBoxProdEdFrame;
    UnidFr: TComboBoxProdEdFrame;
    ICMSFr: TComboBoxProdEdFrame;

    constructor Create(AOwner: TComponent; //
      pSelecioneProximoProc: TProcedureOfObject; //
      //
      pProdEnt: IProdEnt; pProdDBI: IEntDBI;

      //
      pFabrDBI: IEntDBI; pTipoDBI: IEntDBI; pUnidDBI: IEntDBI;
      pICMSDBI: IEntDBI; //

      //
      pBarrasDBI: IBarrasDBI;

      //
      pFabrDataSetFormCreator: IFormCreator;
      pProdTipoDataSetFormCreator: IFormCreator;
      pProdUnidDataSetFormCreator: IFormCreator;
      pProdICMSDataSetFormCreator: IFormCreator;

      //
      pAppObj: IAppObj;
      //
      pErroOutput: IOutput); reintroduce;
    destructor Destroy; override;
  end;

  // var
  // RetagProdEdObrigFrame: TRetagProdEdObrigFrame;

implementation

{$R *.dfm}

uses Sis.Types.Integers, Sis.UI.Controls.TLabeledEdit, App.Retag.Est.Factory,
  App.Est.Types_u, Sis.Types.Codigos.Utils;

{ TRetagProdEdObrigFrame }

procedure TRetagProdEdComunsFrame.AtivoCheckBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key = #13 then
  begin
    key := #0;
    SelecioneProximoProc;
  end;
end;

constructor TRetagProdEdComunsFrame.Create(AOwner: TComponent; //
  pSelecioneProximoProc: TProcedureOfObject; //
  //
  pProdEnt: IProdEnt; pProdDBI: IEntDBI;

  //
  pFabrDBI: IEntDBI; pTipoDBI: IEntDBI; pUnidDBI: IEntDBI; pICMSDBI: IEntDBI; //

  //
  pBarrasDBI: IBarrasDBI;

  //
  pFabrDataSetFormCreator: IFormCreator;
  pProdTipoDataSetFormCreator: IFormCreator;
  pProdUnidDataSetFormCreator: IFormCreator;
  pProdICMSDataSetFormCreator: IFormCreator;

  //
  pAppObj: IAppObj;
  //
  pErroOutput: IOutput);
var
  iTop: integer;
  iLeft: integer;
  I: integer;
begin
  inherited Create(AOwner, pProdEnt, pErroOutput);
  DescrErroLabel.Caption := '';
  DescrRedErroLabel.Caption := '';
  CustoErroLabel.Caption := '';
  PrecoErroLabel.Caption := '';

  SelecioneProximoProc := pSelecioneProximoProc;
  FAppObj := pAppObj;

  IdEdit := TNumEditBtu.Create(Self);
  IdEdit.Parent := Self;
  IdEdit.Alignment := taCenter;
  IdEdit.NCasas := 0;
  IdEdit.NCasasEsq := 7;
  IdEdit.MascEsq := '0000000';
  IdEdit.Caption := 'Código';
  IdEdit.LabelPosition := lpLeft;
  IdEdit.LabelSpacing := 4;
  IdEdit.ReadOnly := true;

  IdEdit.Valor := pProdEnt.Id;

  BarrasFr := TProdBarrasFrame.Create(Self, ProdEnt.ProdBarrasList, FAppObj,
    pBarrasDBI, pProdEnt.Id);

  BarrasFr.Parent := Self;

  FFabrDataSetFormCreator := pFabrDataSetFormCreator;
  FProdTipoDataSetFormCreator := pProdTipoDataSetFormCreator;
  FProdUnidDataSetFormCreator := pProdUnidDataSetFormCreator;
  FProdICMSDataSetFormCreator := pProdICMSDataSetFormCreator;

  // fabr
  FabrFr := TComboBoxProdEdFrame.Create(Self, ProdEnt.ProdFabrEnt, pFabrDBI,
    ErroOutput, FFabrDataSetFormCreator);
  FabrFr.Name := 'FabrComboBoxProdEdFrame';

  // tipo
  TipoFr := TComboBoxProdEdFrame.Create(Self, ProdEnt.ProdTipoEnt, pTipoDBI,
    ErroOutput, FProdTipoDataSetFormCreator);
  TipoFr.Name := 'TipoComboBoxProdEdFrame';

  // Unid
  UnidFr := TComboBoxProdEdFrame.Create(Self, ProdEnt.ProdUnidEnt, pUnidDBI,
    ErroOutput, FProdUnidDataSetFormCreator);
  UnidFr.Name := 'UnidComboBoxProdEdFrame';

  // ICMS
  ICMSFr := TComboBoxProdEdFrame.Create(Self, ProdEnt.ProdICMSEnt, pICMSDBI,
    ErroOutput, FProdICMSDataSetFormCreator);
  ICMSFr.Name := 'ICMSComboBoxProdEdFrame';

  iTop := 2;
  iLeft := 8;

  IdEdit.Left := iLeft + 41;
  IdEdit.Top := iTop;
  IdEdit.Width := 60;

  iLeft := iLeft + IdEdit.Left + IdEdit.Width + 10;

  BarrasFr.Left := iLeft;
  BarrasFr.Top := iTop;

  iLeft := iLeft + BarrasFr.Width + 10;

  FabrFr.Left := iLeft;
  FabrFr.Top := iTop;

  iTop := DescrEdit.Top + DescrEdit.Height + 17;
  iLeft := 6;

  TipoFr.Left := iLeft;
  TipoFr.Top := iTop;

  iLeft := iLeft + TipoFr.Width + 10;

  UnidFr.Left := iLeft;
  UnidFr.Top := iTop;
  UnidFr.ComboBox1.Width := 66;
  UnidFr.Width := UnidFr.BuscaSpeedButton.Left + UnidFr.BuscaSpeedButton.Width;

  iLeft := iLeft + UnidFr.Width + 10;

  ICMSFr.Left := iLeft;
  ICMSFr.Top := iTop;
  ICMSFr.ComboBox1.Width := 125;
  ICMSFr.Width := ICMSFr.BuscaSpeedButton.Left + ICMSFr.BuscaSpeedButton.Width;

  // iLeft := iLeft + ICMSFr.Left + ICMSFr.Width + 10;

  CustoAtuEdit := TNumEditBtu.Create(CustoGroupBox);
  CustoAtuEdit.Parent := CustoGroupBox;
  CustoAtuEdit.Alignment := taRightJustify;
  CustoAtuEdit.NCasas := 4;
  CustoAtuEdit.NCasasEsq := 7;
  // FCustoAtuEdit.MascEsq := '0000000';
  CustoAtuEdit.Caption := 'Atual';
  CustoAtuEdit.ReadOnly := true;
  CustoAtuEdit.LabelPosition := lpLeft;
  CustoAtuEdit.LabelSpacing := 4;
  CustoAtuEdit.TabStop := False;

  CustoNovEdit := TNumEditBtu.Create(CustoGroupBox);
  CustoNovEdit.Parent := CustoGroupBox;
  CustoNovEdit.Alignment := taRightJustify;
  CustoNovEdit.NCasas := 4;
  CustoNovEdit.NCasasEsq := 7;
//  CustoNovEdit.MascEsq := '0000000';
  CustoNovEdit.Caption := 'Novo';
  CustoNovEdit.LabelPosition := lpLeft;
  CustoNovEdit.LabelSpacing := 4;

  // FMargemNumEdit := TNumEditBtu.Create(Self);
  // FMargemNumEdit.Parent := Self;
  // FMargemNumEdit.Alignment := taRightJustify;
  // FMargemNumEdit.NCasas := 4;
  // FMargemNumEdit.NCasasEsq := 3;
  // FMargemNumEdit.MascEsq := '000';
  // FMargemNumEdit.Caption := 'Margem';
  // FMargemNumEdit.LabelPosition := lpLeft;
  // FMargemNumEdit.LabelSpacing := 4;
  //
  // FMargemNumEdit.Width := 50;
  // FMargemNumEdit.Left := FCustoNovEdit.Left+FCustoNovEdit.Width+58;
  // FMargemNumEdit.Top := FCustoNovEdit.Top;
  //
  //

  PrecoAtuEdit := TNumEditBtu.Create(PrecoGroupBox);
  PrecoAtuEdit.Parent := PrecoGroupBox;
  PrecoAtuEdit.Alignment := taRightJustify;
  PrecoAtuEdit.NCasas := 2;
  PrecoAtuEdit.NCasasEsq := 7;
  PrecoAtuEdit.Caption := 'Atual';
  PrecoAtuEdit.ReadOnly := true;
  PrecoAtuEdit.LabelPosition := lpLeft;
  PrecoAtuEdit.LabelSpacing := 4;
  PrecoAtuEdit.TabStop := False;

  PrecoSugEdit := TNumEditBtu.Create(PrecoGroupBox);
  PrecoSugEdit.Parent := PrecoGroupBox;
  PrecoSugEdit.Alignment := taRightJustify;
  PrecoSugEdit.NCasas := 2;
  PrecoSugEdit.NCasasEsq := 7;
  PrecoSugEdit.Caption := 'Sugerido';
  PrecoSugEdit.ReadOnly := true;
  PrecoSugEdit.LabelPosition := lpLeft;
  PrecoSugEdit.LabelSpacing := 4;
  PrecoSugEdit.TabStop := False;

  PrecoNovEdit := TNumEditBtu.Create(PrecoGroupBox);
  PrecoNovEdit.Parent := PrecoGroupBox;
  PrecoNovEdit.Alignment := taRightJustify;
  PrecoNovEdit.NCasas := 2;
  PrecoNovEdit.NCasasEsq := 7;
  PrecoNovEdit.Caption := 'Novo';
  PrecoNovEdit.LabelPosition := lpLeft;
  PrecoNovEdit.LabelSpacing := 4;

  CustoAtuEdit.Width := 85;
  CustoAtuEdit.Left := 38;
  CustoAtuEdit.Top := 15;

  CustoNovEdit.Width := 85;
  CustoNovEdit.Left := CustoAtuEdit.Left + CustoAtuEdit.Width + 38;
  CustoNovEdit.Top := CustoAtuEdit.Top;

  PrecoAtuEdit.Width := 75;
  PrecoAtuEdit.Left := 38;
  PrecoAtuEdit.Top := 15;

  PrecoSugEdit.Width := 75;
  PrecoSugEdit.Left := PrecoAtuEdit.Left + PrecoAtuEdit.Width + 56;
  PrecoSugEdit.Top := PrecoAtuEdit.Top;

  PrecoNovEdit.Width := 75;
  PrecoNovEdit.Left := PrecoSugEdit.Left + PrecoSugEdit.Width + 38;
  PrecoNovEdit.Top := PrecoSugEdit.Top;

  BalDpto := TNumEditBtu.Create(BalGroupBox);
  BalDpto.Parent := BalGroupBox;
  BalDpto.Alignment := taCenter;
  BalDpto.NCasas := 0;
  BalDpto.NCasasEsq := 3;
  BalDpto.MascEsq := '##0';
  BalDpto.Caption := MoldeBalDptoLabeledEdit.EditLabel.Caption;
  // BalDpto.LabelPosition := lpL;
  // BalDpto.LabelSpacing := 4;
  BalDpto.MaxLength := 5;


  BalDpto.Left := MoldeBalDptoLabeledEdit.Left;
  BalDpto.Top := MoldeBalDptoLabeledEdit.Top;
  BalDpto.Width := MoldeBalDptoLabeledEdit.Width;

  BalValidEdit := TNumEditBtu.Create(BalGroupBox);
  BalValidEdit.Parent := BalGroupBox;
  BalValidEdit.Alignment := taCenter;
  BalValidEdit.AutoExit := true;
  BalValidEdit.Caption := 'Validade (Dias)';
  BalValidEdit.EditLabel.Caption :=
    MoldeBalValidEditLabeledEdit.EditLabel.Caption;
  BalValidEdit.MaxLength := 5;
  BalValidEdit.NCasas := 0;
  BalValidEdit.NCasasEsq := 4;
  BalValidEdit.Valor := 0;
  BalValidEdit.MascEsq := '###0';
  // BalValidEdit.LabelPosition := lpCenter;


  BalancaExigeCheckBox.Checked := False;
  BalDpto.TabOrder := 1;
  BalValidEdit.TabOrder := 2;
  BalTextoEtiqMemo.TabOrder := 3;

  BalValidEdit.Left := MoldeBalValidEditLabeledEdit.Left;
  BalValidEdit.Top := MoldeBalValidEditLabeledEdit.Top;
  BalValidEdit.Width := MoldeBalValidEditLabeledEdit.Width;

  //capac emb
  CapacEmbEdit := TNumEditBtu.Create(Self);
  CapacEmbEdit.Parent := Self;

  CapacEmbEdit.Left := MoldeCapacEmbLabeledEdit.Left;
  CapacEmbEdit.Top := MoldeCapacEmbLabeledEdit.Top;
  CapacEmbEdit.Width := MoldeCapacEmbLabeledEdit.Width;

  CapacEmbEdit.Alignment := taCenter;
  CapacEmbEdit.Caption := MoldeCapacEmbLabeledEdit.EditLabel.Caption;

  CapacEmbEdit.LabelPosition := lpLeft;
  CapacEmbEdit.LabelSpacing := 4;

  CapacEmbEdit.MaxLength := 5;
  CapacEmbEdit.NCasas := 0;
  CapacEmbEdit.NCasasEsq := 5;

  CapacEmbEdit.TabOrder := 7;
  //capac emb fim



  //margem
  MargemEdit := TNumEditBtu.Create(Self);
  MargemEdit.Parent := Self;

  MargemEdit.Left := MoldeMargemLabeledEdit.Left;
  MargemEdit.Top := MoldeMargemLabeledEdit.Top;
  MargemEdit.Width := MoldeMargemLabeledEdit.Width;

  MargemEdit.Alignment := taCenter;
  MargemEdit.Caption := MoldeMargemLabeledEdit.EditLabel.Caption;

  MargemEdit.LabelPosition := lpLeft;
  MargemEdit.LabelSpacing := 4;

  MargemEdit.MaxLength := 5;
  MargemEdit.NCasas := 2;
  MargemEdit.NCasasEsq := 3;

  MargemEdit.TabOrder := 7;
  //margem fim

  FWinControlList := TList<Vcl.Controls.TWinControl>.Create;

  FWinControlList.Add(IdEdit);

  FWinControlList.Add(BarrasFr);
  FWinControlList.Add(FabrFr);
  FWinControlList.Add(DescrEdit);
  FWinControlList.Add(DescrRedEdit);

  FWinControlList.Add(TipoFr);
  FWinControlList.Add(UnidFr);
  FWinControlList.Add(ICMSFr);

  FWinControlList.Add(CustoGroupBox);
  FWinControlList.Add(PrecoGroupBox);
  FWinControlList.Add(BalGroupBox);

  FWinControlList.Add(AtivoCheckBox);
  FWinControlList.Add(NcmLabeledEdit);
  FWinControlList.Add(CapacEmbEdit);
  FWinControlList.Add(MargemEdit);
  FWinControlList.Add(NCMLabeledEdit);

  MoldeMargemLabeledEdit.Free;
  MoldeCapacEmbLabeledEdit.Free;
  MoldeBalValidEditLabeledEdit.Free;
  MoldeBalDptoLabeledEdit.Free;

  BalancaExigeCheckBox.Checked := False;
  BalDpto.Valor := 1;
  BalValidEdit.Valor := 0;
  CapacEmbEdit.Valor := 1;
  MargemEdit.Valor := 1;
  NCMLabeledEdit.Text :='';

  for I := 0 to FWinControlList.Count - 1 do
  begin
    FWinControlList[I].TabOrder := I;
  end;
end;

procedure TRetagProdEdComunsFrame.DescrEditChange(Sender: TObject);
begin
  inherited;
  DescrErroLabel.Caption := '';
end;

procedure TRetagProdEdComunsFrame.DescrRedEditChange(Sender: TObject);
begin
  inherited;
  DescrRedErroLabel.Caption := '';

end;

destructor TRetagProdEdComunsFrame.Destroy;
begin
  FWinControlList.Free;
  inherited;
end;

procedure TRetagProdEdComunsFrame.GeraBarrasLabelClick(Sender: TObject);
begin
  inherited;
  BarrasFr.LabeledEdit1.Text := EAN13GetRandom;
end;

end.
