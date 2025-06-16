unit App.UI.Form.Ed.Est.Inventario_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Ed.Est_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  App.Retag.Est.Inventario.Ent, App.Retag.Est.Inventario.DBI,
  Sis.UI.Controls.ComboBoxManager, Sis.DB.DBTypes, CustomEditBtu,
  CustomNumEditBtu, NumEditBtu, Sis.Entities.Types, Sis.Types, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, Sis.Usuario;

type
  TInventarioEdForm = class(TEstEdBasForm)
    procedure QtdNumEditBtuKeyPress(Sender: TObject; var Key: Char);
    procedure QtdNumEditBtuChange(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FInventarioEnt: IInventarioEnt;
    FInventarioDBI: IInventarioDBI;
  protected
    procedure AjusteControles; override;
    procedure AjusteTabOrder; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    procedure ProdSelectProdLabeledEditKeyPress(Sender: TObject;
      var Key: Char); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pDBConnection: IDBConnection; pUsuarioLog: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput = nil; pProcessLog: IProcessLog = nil;
      pOutputNotify: IOutput = nil); override;
  end;

var
  InventarioEdForm: TInventarioEdForm;

implementation

{$R *.dfm}

uses App.Retag.Est.Factory, Sis.UI.Controls.Factory, Sis.DB.DataSet.Utils,
  Sis.Types.Floats, App.Retag.Est.InventarioItem, Data.DB, Sis.Sis.Constants,
  Sis.Types.strings_u;

procedure TInventarioEdForm.AjusteControles;
begin
  inherited;
  ProdSelectFrame.SetFocus;
end;

procedure TInventarioEdForm.AjusteTabOrder;
begin
  // inherited;
  CodLabeledEdit.TabOrder := 0;
  ProdSelectFrame.TabOrder := 1;
  QtdNumEditBtu.TabOrder := 2;
end;

procedure TInventarioEdForm.ControlesToEnt;
var
  oItem: IRetagInventarioItem;
  iOrdem: SmallInt;
  i: integer;
begin
  inherited;
  if EntEd.State = dsInsert then
  begin
    iOrdem := FInventarioEnt.Items.Count;
    i := iOrdem - 1;

    oItem := RetagInventarioItemCreate(iOrdem, ProdSelectFrame.ProdId,
      ProdSelectFrame.ProdDescrRed, ProdSelectFrame.ProdFabrNome, '' { unid } ,
      QtdNumEditBtu.Valor, DATA_ZERADA { criadoem } );

    FInventarioEnt.Items.Add(oItem);
  end;
end;

constructor TInventarioEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pDBConnection: IDBConnection;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput);
begin
  inherited;
  FInventarioEnt := EntEdCastToInventarioEnt(pEntEd);
  // FInventarioEnt := pEntEd as IInventarioEnt;
  FInventarioDBI := EntDBICastToInventarioDBI(pEntDBI);
end;

procedure TInventarioEdForm.EntToControles;
var
  s: string;
begin
  inherited;
  s := '';
  if FInventarioEnt.InventarioId > 0 then
  begin
    s := FInventarioEnt.GetCod;
  end;

  CodLabeledEdit.Text := s;

  // if FInventarioEnt.ItemIndex > -1 then
  // begin
  // FInventarioEnt.Items[FInventarioEnt.ItemIndex];
  // end;
end;

procedure TInventarioEdForm.ProdSelectProdLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if (Key >= #32) or (key = #13) then
  begin
    Key := #0;
    ProdSelectFrame.Selecionar;
  end;
end;

procedure TInventarioEdForm.QtdNumEditBtuChange(Sender: TObject);
begin
  inherited;
  MensLimpar;
end;

procedure TInventarioEdForm.QtdNumEditBtuKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    OkAct_Diag.Execute;
  end;
end;

procedure TInventarioEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ProdSelectFrame.ProdLabeledEdit.SetFocus;
end;

end.
