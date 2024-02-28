unit App.UI.Form.Ed.Prod_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, NumEditBtu,
  App.Retag.Est.Prod.Ent, Data.DB, App.UI.Frame.SelectEdit.Fabr_u,
  Sis.UI.Controls.Sanfona_u, App.Retag.Prod.Obrigatorios.SanfonaItem_u;

type
  TProdEdForm = class(TEdBasForm)
    procedure FormCreate(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FIdNumEdit: TNumEditBtu;
    FCustoAtualNumEdit: TNumEditBtu;
    FPrecoAtualNumEdit: TNumEditBtu;
    //FFabrSelectEditFrame: TFabrSelectEditFrame;
    FSanfonaFrame: TSanfonaFrame;
    FProdObrigatoriosSanfonaItemFrame: TProdObrigatoriosSanfonaItemFrame;

    function GetProdEnt: IProdEnt;
    property ProdEnt: IProdEnt read GetProdEnt;
    function GetAlterado: boolean;
    procedure IdCrie;
    procedure CustoCrie;
    procedure PrecoCrie;
    procedure FabrSelectCrie;
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

uses App.Retag.Est.Prod.Ent_u, Sis.UI.Controls.TLabeledEdit, Sis.UI.Controls.Utils;

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

        ObjetivoLabel.Caption := sCaption;
      end;

    dsInsert:
      ;
  end;


//  FIdNumEdit.Left := ObjetivoLabel.Left;
//  FIdNumEdit.Top := 47;
//  FIdNumEdit.Width := 60;

//  FFabrSelectEditFrame.Left := ObjetivoLabel.Left;
//  FFabrSelectEditFrame.Top := 75;

//  FCustoAtualNumEdit.Left := ObjetivoLabel.Left;
//  FCustoAtualNumEdit.Top := 144;
//  FCustoAtualNumEdit.Width := 70;
//
//  FPrecoAtualNumEdit.Left := ObjetivoLabel.Left;;
//  FPrecoAtualNumEdit.Top := 70;
//  FPrecoAtualNumEdit.Width := 70;



end;

function TProdEdForm.ControlesOk: boolean;
begin

end;

procedure TProdEdForm.ControlesToEnt;
begin
  inherited;

end;

function TProdEdForm.DadosOk: boolean;
begin

end;

procedure TProdEdForm.EntToControles;
begin
  inherited;
//  FIdNumEdit.Valor := ProdEnt.Id;
//  DescrLabeledEdit.Text := ProdEnt.Descr;
//  DescrRedLabeledEdit.Text := ProdEnt.DescrRed;
end;

procedure TProdEdForm.FabrSelectCrie;
begin
//  FFabrSelectEditFrame := TFabrSelectEditFrame.Create(Self, ProdEnt.ProdFabrEnt, nil);
//  FFabrSelectEditFrame.Parent := Self;
end;

procedure TProdEdForm.FormCreate(Sender: TObject);
begin
  inherited;
  FSanfonaFrame := TSanfonaFrame.Create(Self);
  FSanfonaFrame.Parent := Self;
  FSanfonaFrame.Align := alClient;
  FSanfonaFrame.TitLabel.Caption := GetObjetivoStr;
  ObjetivoLabel.Visible := false;

  FProdObrigatoriosSanfonaItemFrame := TProdObrigatoriosSanfonaItemFrame.Create(FSanfonaFrame);
  FSanfonaFrame.PegarItem(FProdObrigatoriosSanfonaItemFrame);
  IdCrie;
//  CustoCrie;
//  PrecoCrie;
  FabrSelectCrie;




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
  Result := TProdEnt(EntEd);
end;

function TProdEdForm.GravouOk: boolean;
begin

end;

procedure TProdEdForm.IdCrie;
begin
  exit;
  FIdNumEdit := TNumEditBtu.Create(Self);
  FIdNumEdit.Parent := Self;
  FIdNumEdit.Alignment := taCenter;
  FIdNumEdit.NCasas:=0;
  FIdNumEdit.NCasasEsq:=7;
  FIdNumEdit.MascEsq := '0000000';
  FIdNumEdit.Caption := 'Código';
end;

procedure TProdEdForm.PrecoCrie;
begin
  FPrecoAtualNumEdit := TNumEditBtu.Create(Self);
  FPrecoAtualNumEdit.Parent := Self;
  FPrecoAtualNumEdit.Alignment := taRightJustify;
  FPrecoAtualNumEdit.NCasas:=2;
  FPrecoAtualNumEdit.NCasasEsq:=7;
  FPrecoAtualNumEdit.MascEsq := '';
  FPrecoAtualNumEdit.Caption := 'Preço Atual';
end;

procedure TProdEdForm.CustoCrie;
begin
  FCustoAtualNumEdit := TNumEditBtu.Create(Self);
  FCustoAtualNumEdit.Parent := Self;
  FCustoAtualNumEdit.Alignment := taRightJustify;
  FCustoAtualNumEdit.NCasas:=2;
  FCustoAtualNumEdit.NCasasEsq:=7;
  FCustoAtualNumEdit.MascEsq := '';
  FCustoAtualNumEdit.Caption := 'Custo atual';

end;

procedure TProdEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
//  DescrLabeledEdit.SetFocus;
//  DescrLabeledEdit.Text := 'CANETA DE CD';
//  DescrRedLabeledEdit.Text := 'CANETA DE CD';

//  FFabrSelectEditFrame.IdNumEdit.Valor := 2;


//  PostMessage(FFabrSelectEditFrame.IdNumEdit.Handle, WM_KEYDOWN, VK_RETURN, 0);
//  PostMessage(FFabrSelectEditFrame.IdNumEdit.Handle, WM_KEYUP, VK_RETURN, 0);
end;

end.
