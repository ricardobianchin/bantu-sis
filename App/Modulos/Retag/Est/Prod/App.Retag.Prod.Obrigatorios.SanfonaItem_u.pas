unit App.Retag.Prod.Obrigatorios.SanfonaItem_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Controls.SanfonaItem_u,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TProdObrigatoriosSanfonaItemFrame = class(TSanfonaItemBasFrame)
    Label1: TLabel;
  private
    { Private declarations }
  protected
    function GetNome: string; override;
  public
    { Public declarations }
  end;

//var
//  ProdFabrSanfonaItemFrame: TProdFabrSanfonaItemFrame;

implementation

{$R *.dfm}

{ TProdObrigatoriosSanfonaItemFrame }

function TProdObrigatoriosSanfonaItemFrame.GetNome: string;
begin
  Result := 'Campos Obrigatórios'
end;

end.
