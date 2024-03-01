unit App.Retag.Prod.SanfonaItem.Bas_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Controls.SanfonaItem_u,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.ExtCtrls, App.Retag.Est.Prod.Ent, App.Retag.Est.Factory, Sis.UI.IO.Output;

type
  TProdEdSanfonaItemFrame = class(TSanfonaItemFrame)
  private
    { Private declarations }
  protected
    function GetProdEnt: IProdEnt;
    property ProdEnt: IProdEnt read GetProdEnt;

    procedure ControlesToEnt; virtual; abstract;
    procedure EntToControles; virtual; abstract;
    function ControlesOk: boolean; virtual; abstract;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pProdEnt: IProdEnt; pErroOutput: IOutput); reintroduce;
  end;

var
  ProdEdSanfonaItemFrame: TProdEdSanfonaItemFrame;

implementation

{$R *.dfm}

{ TProdEdSanfonaItemFrame }

constructor TProdEdSanfonaItemFrame.Create(AOwner: TComponent;
  pProdEnt: IProdEnt; pErroOutput: IOutput);
begin
  Inherited Create(AOwner, pProdEnt, pErroOutput);
end;

function TProdEdSanfonaItemFrame.GetProdEnt: IProdEnt;
begin
  Result := EntEdCastToProdEnt(inherited EntEd);
end;

end.
