unit App.Retag.Prod.Compl.SanfonaItem_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.Retag.Prod.SanfonaItem.Bas_u,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TComplProdEdFrame = class(TProdEdSanfonaItemFrame)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ComplProdEdFrame: TComplProdEdFrame;

implementation

{$R *.dfm}

end.
