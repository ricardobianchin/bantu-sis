unit App.UI.Form.Ed.Est_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  App.Retag.Est.ProdSelectFrame_u, Sis.DB.DBTypes, CustomEditBtu,
  CustomNumEditBtu, NumEditBtu, Data.DB, App.Est.EstMovEnt, App.Est.EstMovItem;

type
  TEstEdBasForm = class(TEdBasForm)
    NotaGroupBox: TGroupBox;
    CodLabeledEdit: TLabeledEdit;
    ItemGroupBox: TGroupBox;
    QtdNumEditBtu: TNumEditBtu;
  private
    { Private declarations }
    FProdSelectFrame: TProdSelectFrame;
    FEstMovEnt: IEstMovEnt<IEstMovItem>;
  protected
    procedure AjusteControles; override;
    procedure AjusteTabOrder; virtual; abstract;
    procedure ProdSelectProdLabeledEditKeyPress(Sender: TObject; var Key: Char);
      virtual; abstract;
    procedure ProdSelectSelect(Sender: TObject); virtual;
    function GetObjetivoStr: string; override;
    property ProdSelectFrame: TProdSelectFrame read FProdSelectFrame;
    function GravouOk: boolean; override;

  public
    { Public declarations }

    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pDBConnection: IDBConnection); reintroduce; virtual;
  end;

var
  EstEdBasForm: TEstEdBasForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

{ TEstEdBasForm }

procedure TEstEdBasForm.AjusteControles;
begin
  inherited;
  ReadOnlySet(CodLabeledEdit);
  AjusteTabOrder;
end;

constructor TEstEdBasForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pDBConnection: IDBConnection);
begin
  inherited Create(AOwner, pAppObj, pEntEd, pEntDBI);
  FEstMovEnt := pEntEd as IEstMovEnt<IEstMovItem>;
  //FEstMovEnt: IEstMovEnt<IEstMovItem>;pEntEd as IEstSaidaEnt

  FProdSelectFrame := TProdSelectFrame.Create(ItemGroupBox,
    pDBConnection, pAppObj);

  FProdSelectFrame.ProdLabeledEdit.OnKeyPress :=
    ProdSelectProdLabeledEditKeyPress;
  FProdSelectFrame.OnSelect := ProdSelectSelect;

  FProdSelectFrame.Left := 10;
  FProdSelectFrame.Top := 20;
  QtdNumEditBtu.Left := FProdSelectFrame.Left + FProdSelectFrame.Width + 4 +
    QtdNumEditBtu.EditLabel.Width + QtdNumEditBtu.LabelSpacing;
  QtdNumEditBtu.Top := FProdSelectFrame.Top;

  CodLabeledEdit.TabStop := False;
  Sis.UI.Controls.Utils.ReadOnlySet(CodLabeledEdit, True);
  // CodLabeledEdit.Color := $00D3D7B9;
end;

function TEstEdBasForm.GetObjetivoStr: string;
begin
  if FEstMovEnt.EditandoItem then
  begin
    Result := 'Novo item';
  end
  else
  begin
    Result := 'Nova nota';
  end;
end;

function TEstEdBasForm.GravouOk: boolean;
begin
  Result := EntDBI.Garantir;
end;

procedure TEstEdBasForm.ProdSelectSelect(Sender: TObject);
begin
  MensLimpar;
end;

end.
