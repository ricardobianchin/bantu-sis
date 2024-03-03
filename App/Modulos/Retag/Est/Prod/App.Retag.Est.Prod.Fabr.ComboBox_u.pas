unit App.Retag.Est.Prod.Fabr.ComboBox_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.Retag.Est.Prod.ComboBox_u,
  Vcl.StdCtrls, Vcl.Buttons, App.Retag.Est.Factory, Sis.UI.IO.Output,
  App.Ent.DBI, App.Ent.Ed, Sis.DB.DBTypes;

type
  TFabrComboBoxFrame = class(TComboBoxProdEdFrame)
  private
    { Private declarations }
  public
    { Public declarations }
  constructor Create(AOwner: TComponent; pDBConnection: IDBConnection; pErroOutput: IOutput); reintroduce;
  end;

//var
//  FabrComboBoxFrame: TFabrComboBoxFrame;

implementation

{$R *.dfm}

uses Data.DB;

{ TFabrComboBoxFrame }

constructor TFabrComboBoxFrame.Create(AOwner: TComponent; pDBConnection: IDBConnection; pErroOutput: IOutput);
var
  oEntEd: IEntEd;
  oEntDBI: IEntDBI;
begin
  oEntEd := RetagEstProdFabrEntCreate(dsBrowse);
  oEntDBI := RetagEstProdFabrDBICreate(pDBConnection, oEntEd);

  inherited Create(AOwner, oEntEd, oEntDBI, pErroOutput);
end;

end.
