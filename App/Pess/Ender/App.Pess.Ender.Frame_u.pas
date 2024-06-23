unit App.Pess.Ender.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Data.DB;

type
  TEnderFrame = class(TBasFrame)
  private
    { Private declarations }
//    FPessEnt: IPessEnt;
//    FPessDBI: IPessDBI;
//    EnderPessFDMemTable: TFDMemTable;
  public
    { Public declarations }
//    constructor Create(AOwner: TComponent; ); override;
  end;

var
  EnderFrame: TEnderFrame;

implementation

{$R *.dfm}

end.
