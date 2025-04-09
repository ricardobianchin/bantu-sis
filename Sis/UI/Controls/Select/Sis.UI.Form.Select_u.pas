unit Sis.UI.Form.Select_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Sis.UI.Select, Vcl.ToolWin,
  Vcl.ComCtrls;

type
  TSelectForm = class(TDiagBasForm, ISelect)
    FundoPanel: TPanel;
    BasePanel: TPanel;
    QtdRegsLabel: TLabel;
    ToolsPanel_SelectForm: TPanel;
    ToolBar1_SelectForm: TToolBar;
    ToolButton1: TToolButton;
    ActionList1_SelectForm: TActionList;
    AtuAction: TAction;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AtuActionExecute(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetLastSelected: string; virtual; abstract;
    procedure Atualize; virtual;
    procedure AtualizeQtdRegs; virtual;
  public
    { Public declarations }
    function Execute(pParams: string = ''): Boolean; virtual; abstract;

    property LastSelected: string read GetLastSelected;
    constructor Create(AOwner: TComponent); reintroduce; virtual;
  end;

//var
//  PDVProdSelectForm: TPDVProdSelectForm;

implementation

{$R *.dfm}

{ TSelectForm }

procedure TSelectForm.AtuActionExecute(Sender: TObject);
begin
  inherited;
  Atualize;
end;

procedure TSelectForm.Atualize;
begin
  AtualizeQtdRegs;
end;

procedure TSelectForm.AtualizeQtdRegs;
begin
  QtdRegsLabel.Caption := '';
end;

constructor TSelectForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MensLabel.Parent := FundoPanel;
  AlteracaoTextoLabel.Parent := FundoPanel;
end;

procedure TSelectForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F5:
    begin
      if Shift = [] then
      begin
        Key := 0;
        Atualize;
      end;
    end;
  end;
end;

end.
