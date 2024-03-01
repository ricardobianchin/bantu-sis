unit App.UI.Form.Ed.Prod_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  App.Retag.Est.Prod.Ent, Data.DB, App.UI.Frame.SelectEdit.Fabr_u,
  Sis.UI.Controls.Sanfona_u, App.Retag.Prod.Obrigatorios.SanfonaItem_u;

type
  TProdEdForm = class(TEdBasForm)
    procedure FormCreate(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    // FFabrSelectEditFrame: TFabrSelectEditFrame;
    FSanfonaFrame: TSanfonaFrame;
    FObrigFrame: TObrigatoriosProdEdFrame;

    function GetProdEnt: IProdEnt;
    property ProdEnt: IProdEnt read GetProdEnt;
    function GetAlterado: boolean;
  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;
    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
    function GravouOk: boolean; override;
  public
    { Public declarations }
  end;

var
  ProdEdForm: TProdEdForm;

implementation

uses {App.Retag.Est.Prod.Ent_u, }Sis.UI.Controls.TLabeledEdit,
  Sis.UI.Controls.Utils, Sis.Types.Integers, App.Retag.Est.Factory;

{$R *.dfm}

procedure TProdEdForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sDes: string;
begin
  inherited;
  case EntEd.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sNom := ProdEnt.NomeEnt;
        sDes := ProdEnt.Descr;

        sFormat := 'Alterando %s: %s';
        sCaption := Format(sFormat, [sNom, sDes]);

        FSanfonaFrame.TitLabel.Caption := sCaption;
      end;

    dsInsert:
      ;
  end;

end;

function TProdEdForm.ControlesOk: boolean;
begin
  Result := FObrigFrame.ControlesOk;
  if not Result then
    exit;
end;

procedure TProdEdForm.ControlesToEnt;
begin
  inherited;
  FObrigFrame.ControlesToEnt;
end;

function TProdEdForm.DadosOk: boolean;
var
  sId: string;
  sIdAtual: string;
  sFrase: string;
begin
  Result := inherited DadosOk;
  if not Result then
    exit;

  sId := VarToStr(EntDBI.GetExistente(FObrigFrame.GetUniqueValues, sFrase));
  Result := sId = '';
  if not Result then
  begin
    ErroOutput.Exibir(sFrase);
    FObrigFrame.Foque;
    exit;
  end;
end;

procedure TProdEdForm.EntToControles;
begin
  inherited;
  FObrigFrame.EntToControles;
end;

procedure TProdEdForm.FormCreate(Sender: TObject);
begin
  inherited;
  FSanfonaFrame := TSanfonaFrame.Create(Self, ErroOutput);
  FSanfonaFrame.Parent := Self;
  FSanfonaFrame.Align := alClient;
  FSanfonaFrame.TitLabel.Caption := GetObjetivoStr;
  ObjetivoLabel.Visible := false;

  FObrigFrame := TObrigatoriosProdEdFrame.Create(FSanfonaFrame,
    ProdEnt, ErroOutput);
  FSanfonaFrame.PegarItem(FObrigFrame);
end;

function TProdEdForm.GetAlterado: boolean;
begin
  Result := true;
end;

function TProdEdForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sDes: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := ProdEnt.NomeEnt;
  sDes := ProdEnt.Descr;

  sFormat := '%s %s: %s';
  Result := Format(sFormat, [sTit, sNom, sDes]);
end;

function TProdEdForm.GetProdEnt: IProdEnt;
begin
  Result := EntEdCastToProdEnt(EntEd);
end;

function TProdEdForm.GravouOk: boolean;
var
  sFrase: string;
begin
  Result := EntDBI.GarantirReg;
  if not Result then
  begin
    sFrase := 'Erro ao gravar ' + EntEd.NomeEnt;
    ErroOutput.Exibir(sFrase);
    FObrigFrame.Foque;
    exit;
  end;

end;

procedure TProdEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  //  FObrigFrame.FIdNumEdit
  FObrigFrame.Foque;

  FObrigFrame.DescrLabeledEdit.Text := 'CANETA DE CD';
  FObrigFrame.DescrRedLabeledEdit.Text := 'CANETA DE CD';
  FObrigFrame.FabrIdLabeledEdit.Text := 'PILOT';
  FObrigFrame.FabrIdLabeledEdit.Tag := 2;

//  OkAct_Diag.Execute;

//  ObrigatoriosProdEdFrame.FCustoAtualNumEdit
//  ObrigatoriosProdEdFrame.FPrecoAtualNumEdit: TNumEditBtu;



  // FFabrSelectEditFrame.IdNumEdit.Valor := 2;

  // PostMessage(FFabrSelectEditFrame.IdNumEdit.Handle, WM_KEYDOWN, VK_RETURN, 0);
  // PostMessage(FFabrSelectEditFrame.IdNumEdit.Handle, WM_KEYUP, VK_RETURN, 0);
end;

end.
