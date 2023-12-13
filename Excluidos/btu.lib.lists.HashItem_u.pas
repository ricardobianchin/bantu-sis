unit btu.lib.lists.HashItem_u;

interface

uses btu.lib.lists.IdItem_u, btu.lib.lists.HashItem_i, Vcl.Controls;

type
  THashItem = class(TIdItem, IHashItem)
  private
    FDescr:string;
    function GetDescr:string;
    procedure SetDescr(const Value:string);
  protected
    function GetAsStringCSV: string;virtual;
    function GetAsCaption: TCaption;virtual;

  public
    procedure Zerar;override;

    property Descr:string read GetDescr write SetDescr;
    constructor Create(pDescr:string=''; pId:integer=0);

    property AsStringCSV: string read GetAsStringCSV;
    property AsCaption: TCaption read GetAsCaption;
  end;

implementation

uses sysutils;

{ THashItem }

constructor THashItem.Create(pDescr: string; pId: integer);
begin
  inherited Create(pId);
  FDescr := pDescr
end;

function THashItem.GetAsCaption: TCaption;
begin
  result := Id.ToString +' - ' +Descr;
end;

function THashItem.GetAsStringCSV: string;
begin
  result := Id.ToString +';' +Descr;
end;

function THashItem.GetDescr: string;
begin
  result := FDescr;
end;

procedure THashItem.SetDescr(const Value: string);
begin
  FDescr := Value;
end;

procedure THashItem.Zerar;
begin
  inherited Zerar;
  SetDescr('');
end;

end.
