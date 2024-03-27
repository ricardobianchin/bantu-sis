unit App.UI.Controls.ComboBox.Select.DB.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Controls.ComboBox.Select.Frame_u,
  Vcl.StdCtrls, Vcl.Buttons, App.Ent.Ed, Sis.UI.IO.Output, App.Ent.DBI,
  Sis.DB.DBTypes, System.Actions, Vcl.ActnList, Sis.UI.FormCreator, Sis.Types;

type
  TComboBoxSelectDBFrame = class(TComboBoxSelectBasFrame)
    procedure BuscaSpeedButtonClick(Sender: TObject);
  private
    { Private declarations }
    FEntEd: IEntEd;
    FEntDBI: IEntDBI;
    FErroOutput: IOutput;
    FFormCreator: IFormCreator;

    function GetEntEd: IEntEd;
    function GetEntDBI: IEntDBI;
    function GetErroOutput: IOutput;
  protected
    property ErroOutput: IOutput read GetErroOutput;
  protected
    function GetCaption: string; override;
  public
    { Public declarations }
    property EntEd: IEntEd read GetEntEd;
    property EntDBI: IEntDBI read GetEntDBI;
    constructor Create(AOwner: TComponent; pEntEd: IEntEd; pEntDBI: IEntDBI;
      pErroOutput: IOutput; pFormCreator: IFormCreator); reintroduce;
    procedure Preencha(pDBConnection: IDBConnection = nil);
  end;

var
  ComboBoxSelectDBFrame: TComboBoxSelectDBFrame;

implementation

{$R *.dfm}
{ TComboBoxSelectDBFrame }

procedure TComboBoxSelectDBFrame.BuscaSpeedButtonClick(Sender: TObject);
var
  Resultado: boolean;
  SelectItem: TSelectItem;
  Index: integer;
begin
  inherited;
  SelectItem.Id := Id;
  Resultado := FFormCreator.PergSelect(SelectItem);
  if not Resultado then
    exit;

  Preencha(nil);

  Index := ComboBox1.Items.IndexOfObject(Pointer(SelectItem.Id));

  if index < 0 then
    exit;

  ComboBox1.ItemIndex := Index;
end;

constructor TComboBoxSelectDBFrame.Create(AOwner: TComponent; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pErroOutput: IOutput; pFormCreator: IFormCreator);
begin
  FEntEd := pEntEd;
  // vem antes pois no create chamará getcaption, que, aqui, depente da ent
  inherited Create(AOwner);
  FEntDBI := pEntDBI;
  FErroOutput := pErroOutput;
  FFormCreator := pFormCreator;
end;

function TComboBoxSelectDBFrame.GetCaption: string;
begin
  Result := FEntEd.NomeEnt;
end;

function TComboBoxSelectDBFrame.GetEntDBI: IEntDBI;
begin
  Result := FEntDBI;
end;

function TComboBoxSelectDBFrame.GetEntEd: IEntEd;
begin
  Result := FEntEd;
end;

function TComboBoxSelectDBFrame.GetErroOutput: IOutput;
begin
  Result := FErroOutput;
end;

procedure TComboBoxSelectDBFrame.Preencha(pDBConnection: IDBConnection);
begin
  FEntDBI.ListaSelectGet(ComboBox1.Items, pDBConnection);
end;

end.
