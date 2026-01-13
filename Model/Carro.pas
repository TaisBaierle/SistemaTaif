unit Carro;

interface

type
  TCarro = class
  private
    FIdCarro: Integer;
    FModelo: string;
    FDataLancamento: TDate;
  public
    property IdCarro: Integer read FIdCarro write FIdCarro;
    property Modelo: string read FModelo write FModelo;
    property DataLancamento: TDate read FDataLancamento write FDataLancamento;
  end;

implementation

end.

