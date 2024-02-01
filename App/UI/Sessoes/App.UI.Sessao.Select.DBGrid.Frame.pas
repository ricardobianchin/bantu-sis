unit App.UI.Sessao.Select.DBGrid.Frame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.DBGrid_u, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  TSessaoSelectDBGridFrame = class(TDBGridFrame)
    FDMemTable1SessaoIndex: TLargeintField;
    FDMemTable1UsuarioApelido: TStringField;
    FDMemTable1ModuloNome: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  SessaoSelectDBGridFrame: TSessaoSelectDBGridFrame;

implementation

{$R *.dfm}

end.
