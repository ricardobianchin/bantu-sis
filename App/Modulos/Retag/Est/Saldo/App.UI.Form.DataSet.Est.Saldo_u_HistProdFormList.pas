unit App.UI.Form.DataSet.Est.Saldo_u_HistProdFormList;

interface

uses Sis.Types, Vcl.Forms;

type
  IHistProdFormList = interface
    ['{8B1B5B12-D1C3-4F66-9513-E40C116C04A2}']
    procedure AddRecord(AProdId: TId; AForm: TForm);
    function FindIndexByProdId(AProdId: TId): Integer;
    procedure RemoveByProdId(AProdId: TId);
    procedure Clear;
    function Count: Integer;
    procedure BringToFront(AProdId: TId);
    procedure FecheForms;
  end;


implementation

end.
