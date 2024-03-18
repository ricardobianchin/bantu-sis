unit App.UI.Frame.Retag.Prod.Ed.Obrig_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Frame.Bas.Retag.Prod.Ed_u,
  App.Retag.Est.Prod.Ent, Vcl.Mask, Sis.UI.IO.Output, NumEditBtu,
  Sis.UI.Controls.ComboBoxManager, App.Ent.DBI, App.Retag.Est.Prod.ComboBox_u,
  Sis.DB.DBTypes,
  App.Retag.Est.Prod.Natu.Ent,
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
  TRetagProdEdObrigFrame = class(TRetagProdEdBasFrame)
    NatuLabel: TLabel;
    DescrEdit: TLabeledEdit;
    DescrRedEdit: TLabeledEdit;
    NatuCombo: TComboBox;
    CustoGroupBox: TGroupBox;
    PrecoGroupBox: TGroupBox;
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

    NatuManager: IComboBoxManager;

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

uses Sis.Types.Integers, Sis.UI.Controls.TLabeledEdit, App.Retag.Est.Factory;

{ TRetagProdEdObrigFrame }

constructor TRetagProdEdObrigFrame.Create(AOwner: TComponent;
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

  IdEdit.Left := 45;
  IdEdit.Top := 2;
  IdEdit.Width := 60;

  NatuManager := ProdNatuComboBoxManagerCreate(NatuCombo);

  BarrasFr := TProdBarrasFrame.Create(Self, ProdEnt.ProdBarrasList,
    FAppInfo);
  BarrasFr.Parent := Self;
  BarrasFr.Left := NatuCombo.Left ;//+ NatuCombo.Width + 10;
  BarrasFr.Top := NatuCombo.Top;

  FFabrDataSetFormCreator := pFabrDataSetFormCreator;
  FProdTipoDataSetFormCreator := pProdTipoDataSetFormCreator;
  FProdUnidDataSetFormCreator := pProdUnidDataSetFormCreator;
  FProdICMSDataSetFormCreator := pProdICMSDataSetFormCreator;

  // FabrComboBoxCrie(pFabrDBI, FFabrDataSetFormCreator);

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

  FabrFr.Left := BarrasFr.Left +
    BarrasFr.Width + 10;
  FabrFr.Top := NatuCombo.Top;

  TipoFr.Left := 4;
  TipoFr.Top := DescrEdit.Top + DescrEdit.Height + 17;

  UnidFr.Left := TipoFr.Left +
    TipoFr.Width + 10;
  UnidFr.Top := TipoFr.Top;
  UnidFr.ComboBox1.Width := 66;
  UnidFr.Width := UnidFr.BuscaSpeedButton.Left +
    UnidFr.BuscaSpeedButton.Width;

  ICMSFr.Left := UnidFr.Left +
    UnidFr.Width + 10;
  ICMSFr.Top := TipoFr.Top;
  ICMSFr.ComboBox1.Width := 125;
  ICMSFr.Width := ICMSFr.BuscaSpeedButton.Left +
    ICMSFr.BuscaSpeedButton.Width;

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

  CustoAtuEdit.Width := 85;
  CustoAtuEdit.Left := 38;
  CustoAtuEdit.Top := 15;

  CustoNovEdit := TNumEditBtu.Create(CustoGroupBox);
  CustoNovEdit.Parent := CustoGroupBox;
  CustoNovEdit.Alignment := taRightJustify;
  CustoNovEdit.NCasas := 6;
  CustoNovEdit.NCasasEsq := 7;
  CustoNovEdit.MascEsq := '0000000';
  CustoNovEdit.Caption := 'Novo';
  CustoNovEdit.LabelPosition := lpLeft;
  CustoNovEdit.LabelSpacing := 4;

  CustoNovEdit.Width := 85;
  CustoNovEdit.Left := CustoAtuEdit.Left+CustoAtuEdit.Width+38;
  CustoNovEdit.Top := CustoAtuEdit.Top;
//

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
//  FPrecoAtuEdit.MascEsq := '0000000';
  PrecoAtuEdit.Caption := 'Atual';
  PrecoAtuEdit.ReadOnly := True;
  PrecoAtuEdit.LabelPosition := lpLeft;
  PrecoAtuEdit.LabelSpacing := 4;

  PrecoAtuEdit.Width := 75;
  PrecoAtuEdit.Left := 38;
  PrecoAtuEdit.Top := 15;
  //
  PrecoSugEdit := TNumEditBtu.Create(PrecoGroupBox);
  PrecoSugEdit.Parent := PrecoGroupBox;
  PrecoSugEdit.Alignment := taRightJustify;
  PrecoSugEdit.NCasas := 2;
  PrecoSugEdit.NCasasEsq := 7;
//  FPrecoSugEdit.MascEsq := '0000000';
  PrecoSugEdit.Caption := 'Sugerido';
  PrecoSugEdit.ReadOnly := True;
  PrecoSugEdit.LabelPosition := lpLeft;
  PrecoSugEdit.LabelSpacing := 4;

  PrecoSugEdit.Width := 75;
  PrecoSugEdit.Left := PrecoAtuEdit.Left+PrecoAtuEdit.Width+56;
  PrecoSugEdit.Top := PrecoAtuEdit.Top;

  //
  PrecoNovEdit := TNumEditBtu.Create(PrecoGroupBox);
  PrecoNovEdit.Parent := PrecoGroupBox;
  PrecoNovEdit.Alignment := taRightJustify;
  PrecoNovEdit.NCasas := 2;
  PrecoNovEdit.NCasasEsq := 7;
//  FPrecoNovEdit.MascEsq := '0000000';
  PrecoNovEdit.Caption := 'Novo';
  PrecoNovEdit.LabelPosition := lpLeft;
  PrecoNovEdit.LabelSpacing := 4;

  PrecoNovEdit.Width := 75;
  PrecoNovEdit.Left := PrecoSugEdit.Left+PrecoSugEdit.Width+38;
  PrecoNovEdit.Top := PrecoSugEdit.Top;
end;

end.
