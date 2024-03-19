unit App.UI.Frame.Retag.Prod.Ed.Comuns_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Frame.Bas.Retag.Prod.Ed_u,
  App.Retag.Est.Prod.Ent, Vcl.Mask, Sis.UI.IO.Output, NumEditBtu,
  Sis.UI.Controls.ComboBoxManager, App.Ent.DBI, App.Retag.Est.Prod.ComboBox_u,
  Sis.DB.DBTypes,
  Sis.UI.FormCreator,
  App.Retag.Est.Prod.Barras.Frame_u, App.AppInfo
  //
    , App.Retag.Est.Prod.Fabr.Ent //
    , App.Retag.Est.Prod.Tipo.Ent //
    , App.Retag.Est.Prod.Unid.Ent //
    , App.Retag.Est.Prod.ICMS.Ent, Vcl.NumberBox, Vcl.StdCtrls, Vcl.ExtCtrls //
  //
    ;

type
  TRetagProdEdComunsFrame = class(TRetagProdEdBasFrame)
    DescrEdit: TLabeledEdit;
    DescrRedEdit: TLabeledEdit;
    CustoGroupBox: TGroupBox;
    PrecoGroupBox: TGroupBox;
    BalGroupBox: TGroupBox;
    BalUtilizaTitLabel: TLabel;
    BalTextoEtiqTitLabel: TLabel;
    BalUtilizaComboBox: TComboBox;
    BalTextoEtiqMemo: TMemo;
    LocalizLabeledEdit: TLabeledEdit;
    MoldeQtdNaEmbLabeledEdit: TLabeledEdit;
    AtivoCheckBox: TCheckBox;
    MoldeBalDptoLabeledEdit: TLabeledEdit;
    MoldeBalValidEditLabeledEdit: TLabeledEdit;
    procedure LocalizLabeledEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }


    FFabrDataSetFormCreator: IFormCreator;
    FProdTipoDataSetFormCreator: IFormCreator;
    FProdUnidDataSetFormCreator: IFormCreator;
    FProdICMSDataSetFormCreator: IFormCreator;

    FAppInfo: IAppInfo;
  public
    { Public declarations }

    IdEdit: TNumEditBtu;
    BarrasFr: TProdBarrasFrame;

    CustoAtuEdit: TNumEditBtu;
    CustoNovEdit: TNumEditBtu;

//    FMargemNumEdit: TNumEditBtu;

    PrecoAtuEdit: TNumEditBtu;
    PrecoSugEdit: TNumEditBtu;
    PrecoNovEdit: TNumEditBtu;

    BalDpto: TNumEditBtu;
    BalValidEdit: TNumEditBtu;
    CapacEmbEdit: TNumEditBtu;


    FabrFr: TComboBoxProdEdFrame;
    TipoFr: TComboBoxProdEdFrame;
    UnidFr: TComboBoxProdEdFrame;
    ICMSFr: TComboBoxProdEdFrame;

    constructor Create(AOwner: TComponent;
      //
      pProdEnt: IProdEnt; pProdDBI: IEntDBI;

      //
      pFabrDBI: IEntDBI; pTipoDBI: IEntDBI; pUnidDBI: IEntDBI;
      pICMSDBI: IEntDBI;

      //
      pFabrDataSetFormCreator: IFormCreator;
      pProdTipoDataSetFormCreator: IFormCreator;
      pProdUnidDataSetFormCreator: IFormCreator;
      pProdICMSDataSetFormCreator: IFormCreator;

      //
      pAppInfo: IAppInfo;
      //
      pErroOutput: IOutput); reintroduce;
  end;

//var
//  RetagProdEdObrigFrame: TRetagProdEdObrigFrame;

implementation

{$R *.dfm}

uses Sis.Types.Integers, Sis.UI.Controls.TLabeledEdit, App.Retag.Est.Factory, App.Est.Types_u;

{ TRetagProdEdObrigFrame }

constructor TRetagProdEdComunsFrame.Create(AOwner: TComponent;
  //
  pProdEnt: IProdEnt; pProdDBI: IEntDBI;

  //
  pFabrDBI: IEntDBI; pTipoDBI: IEntDBI; pUnidDBI: IEntDBI; pICMSDBI: IEntDBI;

  //
  pFabrDataSetFormCreator: IFormCreator;
  pProdTipoDataSetFormCreator: IFormCreator;
  pProdUnidDataSetFormCreator: IFormCreator;
  pProdICMSDataSetFormCreator: IFormCreator;

  //
  pAppInfo: IAppInfo;
  //
  pErroOutput: IOutput);
var
  iTop: integer;
  iLeft: integer;
begin
  inherited Create(AOwner, pProdEnt, pErroOutput);
  FAppInfo := pAppInfo;

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

  BarrasFr := TProdBarrasFrame.Create(Self, ProdEnt.ProdBarrasList,
    FAppInfo);
  BarrasFr.Parent := Self;

  FFabrDataSetFormCreator := pFabrDataSetFormCreator;
  FProdTipoDataSetFormCreator := pProdTipoDataSetFormCreator;
  FProdUnidDataSetFormCreator := pProdUnidDataSetFormCreator;
  FProdICMSDataSetFormCreator := pProdICMSDataSetFormCreator;

  // fabr
  FabrFr := TComboBoxProdEdFrame.Create(Self,
    ProdEnt.ProdFabrEnt, pFabrDBI, ErroOutput, FFabrDataSetFormCreator);
  FabrFr.Name := 'FabrComboBoxProdEdFrame';

  // tipo
  TipoFr := TComboBoxProdEdFrame.Create(Self,
    ProdEnt.ProdTipoEnt, pTipoDBI, ErroOutput, FProdTipoDataSetFormCreator);
  TipoFr.Name := 'TipoComboBoxProdEdFrame';

  // Unid
  UnidFr := TComboBoxProdEdFrame.Create(Self,
    ProdEnt.ProdUnidEnt, pUnidDBI, ErroOutput, FProdUnidDataSetFormCreator);
  UnidFr.Name := 'UnidComboBoxProdEdFrame';

  // ICMS
  ICMSFr := TComboBoxProdEdFrame.Create(Self,
    ProdEnt.ProdICMSEnt, pICMSDBI, ErroOutput, FProdICMSDataSetFormCreator);
  ICMSFr.Name := 'ICMSComboBoxProdEdFrame';

  iTop := 2;
  iLeft := 4;

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
  iLeft := 4;

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

  //iLeft := iLeft + ICMSFr.Left + ICMSFr.Width + 10;

  CustoAtuEdit := TNumEditBtu.Create(CustoGroupBox);
  CustoAtuEdit.Parent := CustoGroupBox;
  CustoAtuEdit.Alignment := taRightJustify;
  CustoAtuEdit.NCasas := 6;
  CustoAtuEdit.NCasasEsq := 7;
//  FCustoAtuEdit.MascEsq := '0000000';
  CustoAtuEdit.Caption := 'Atual';
  CustoAtuEdit.ReadOnly := True;
  CustoAtuEdit.LabelPosition := lpLeft;
  CustoAtuEdit.LabelSpacing := 4;

  CustoNovEdit := TNumEditBtu.Create(CustoGroupBox);
  CustoNovEdit.Parent := CustoGroupBox;
  CustoNovEdit.Alignment := taRightJustify;
  CustoNovEdit.NCasas := 6;
  CustoNovEdit.NCasasEsq := 7;
  CustoNovEdit.MascEsq := '0000000';
  CustoNovEdit.Caption := 'Novo';
  CustoNovEdit.LabelPosition := lpLeft;
  CustoNovEdit.LabelSpacing := 4;

//  FMargemNumEdit := TNumEditBtu.Create(Self);
//  FMargemNumEdit.Parent := Self;
//  FMargemNumEdit.Alignment := taRightJustify;
//  FMargemNumEdit.NCasas := 4;
//  FMargemNumEdit.NCasasEsq := 3;
//  FMargemNumEdit.MascEsq := '000';
//  FMargemNumEdit.Caption := 'Margem';
//  FMargemNumEdit.LabelPosition := lpLeft;
//  FMargemNumEdit.LabelSpacing := 4;
//
//  FMargemNumEdit.Width := 50;
//  FMargemNumEdit.Left := FCustoNovEdit.Left+FCustoNovEdit.Width+58;
//  FMargemNumEdit.Top := FCustoNovEdit.Top;
//
//

  PrecoAtuEdit := TNumEditBtu.Create(PrecoGroupBox);
  PrecoAtuEdit.Parent := PrecoGroupBox;
  PrecoAtuEdit.Alignment := taRightJustify;
  PrecoAtuEdit.NCasas := 2;
  PrecoAtuEdit.NCasasEsq := 7;
  PrecoAtuEdit.Caption := 'Atual';
  PrecoAtuEdit.ReadOnly := True;
  PrecoAtuEdit.LabelPosition := lpLeft;
  PrecoAtuEdit.LabelSpacing := 4;

  PrecoSugEdit := TNumEditBtu.Create(PrecoGroupBox);
  PrecoSugEdit.Parent := PrecoGroupBox;
  PrecoSugEdit.Alignment := taRightJustify;
  PrecoSugEdit.NCasas := 2;
  PrecoSugEdit.NCasasEsq := 7;
  PrecoSugEdit.Caption := 'Sugerido';
  PrecoSugEdit.ReadOnly := True;
  PrecoSugEdit.LabelPosition := lpLeft;
  PrecoSugEdit.LabelSpacing := 4;

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
  CustoNovEdit.Left := CustoAtuEdit.Left+CustoAtuEdit.Width+38;
  CustoNovEdit.Top := CustoAtuEdit.Top;

  PrecoAtuEdit.Width := 75;
  PrecoAtuEdit.Left := 38;
  PrecoAtuEdit.Top := 15;

  PrecoSugEdit.Width := 75;
  PrecoSugEdit.Left := PrecoAtuEdit.Left+PrecoAtuEdit.Width+56;
  PrecoSugEdit.Top := PrecoAtuEdit.Top;

  PrecoNovEdit.Width := 75;
  PrecoNovEdit.Left := PrecoSugEdit.Left+PrecoSugEdit.Width+38;
  PrecoNovEdit.Top := PrecoSugEdit.Top;

  BalDpto := TNumEditBtu.Create(BalGroupBox);
  BalDpto.Parent := BalGroupBox;
  BalDpto.Alignment := taCenter;
  BalDpto.NCasas := 0;
  BalDpto.NCasasEsq := 2;
  BalDpto.MascEsq := '00';
  BalDpto.Caption := MoldeBalDptoLabeledEdit.EditLabel.Caption;
//  BalDpto.LabelPosition := lpL;
//  BalDpto.LabelSpacing := 4;
  BalDpto.MaxLength := 5;

  BalDpto.Left := MoldeBalDptoLabeledEdit.Left;
  BalDpto.Top := MoldeBalDptoLabeledEdit.Top;
  BalDpto.Width := MoldeBalDptoLabeledEdit.Width;

  BalValidEdit := TNumEditBtu.Create(BalGroupBox);
  BalValidEdit.Parent := BalGroupBox;
  BalValidEdit.Alignment := taCenter;
  BalValidEdit.AutoExit := True;
  BalValidEdit.Caption := 'Validade (Dias)';
  BalValidEdit.EditLabel.Caption := MoldeBalValidEditLabeledEdit.EditLabel.Caption;
  BalValidEdit.MaxLength := 5;
  BalValidEdit.NCasas := 0;
  BalValidEdit.NCasasEsq := 4;
  BalValidEdit.Valor := 0;
  BalValidEdit.MascEsq := '###0';
//  BalValidEdit.LabelPosition := lpCenter;

  BalValidEdit.Left := MoldeBalValidEditLabeledEdit.Left;
  BalValidEdit.Top := MoldeBalValidEditLabeledEdit.Top;
  BalValidEdit.Width := MoldeBalValidEditLabeledEdit.Width;

  CapacEmbEdit := TNumEditBtu.Create(Self);
  CapacEmbEdit.Parent := Self;

  CapacEmbEdit.Left := MoldeQtdNaEmbLabeledEdit.Left;
  CapacEmbEdit.Top := MoldeQtdNaEmbLabeledEdit.Top;
  CapacEmbEdit.Width := MoldeQtdNaEmbLabeledEdit.Width;

  CapacEmbEdit.Alignment := taCenter;
  CapacEmbEdit.Caption := MoldeQtdNaEmbLabeledEdit.EditLabel.Caption;

  CapacEmbEdit.LabelPosition := lpLeft;
  CapacEmbEdit.LabelSpacing := 4;

  CapacEmbEdit.MaxLength := 5;
  CapacEmbEdit.NCasas := 0;
  CapacEmbEdit.NCasasEsq := 5;

  MoldeQtdNaEmbLabeledEdit.Free;
  MoldeBalValidEditLabeledEdit.Free;
  MoldeBalDptoLabeledEdit.Free;

  App.Est.Types_u.BalancaTipoStrToSL(BalUtilizaComboBox.Items);
  BalDpto.Valor := 1;
  BalValidEdit.Valor := 0;
  CapacEmbEdit.Valor := 1;
end;

procedure TRetagProdEdComunsFrame.LocalizLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

end.
