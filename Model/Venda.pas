unit Venda;

interface

type
  TVenda = class
  private
    FIdVenda: Integer;
    FIdCliente: Integer;
    FIdCarro: Integer;
    FDataVenda: TDate;
  public
    property IdVenda: Integer read FIdVenda write FIdVenda;
    property IdCliente: Integer read FIdCliente write FIdCliente;
    property IdCarro: Integer read FIdCarro write FIdCarro;
    property DataVenda: TDate read FDataVenda write FDataVenda;
  end;

implementation

end.

