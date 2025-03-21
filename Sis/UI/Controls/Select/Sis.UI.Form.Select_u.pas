unit Sis.UI.Form.Select_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Sis.UI.Select;

type
  TSelectForm = class(TDiagBasForm, ISelect)
    FundoPanel: TPanel;
  private
    { Private declarations }
  protected
    function GetLastSelected: string; virtual; abstract;
  public
    { Public declarations }
    function Perg(pParms: string = ''): Boolean; virtual; abstract;

    property LastSelected: string read GetLastSelected;
    constructor Create(AOwner: TComponent); override;
  end;

//var
//  PDVProdSelectForm: TPDVProdSelectForm;

implementation

{$R *.dfm}

{ TSelectForm }

constructor TSelectForm.Create(AOwner: TComponent);
begin
  inherited;
  MensLabel.Parent := FundoPanel;
  AlteracaoTextoLabel.Parent := FundoPanel;
end;

end.
