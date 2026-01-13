unit CarroService;

interface

type
  TCarroService = class
  public
    procedure InserirCarrosPadrao;
  end;

implementation

uses
  SysUtils,
  Carro,
  CarroDAO,
  SistemaSorteioData,
  UDFConstantes;

procedure TCarroService.InserirCarrosPadrao;
var
  LIndice: Integer;
  LCarro: TCarro;
  LDAO: TCarroDAO;
begin
  LDAO := TCarroDAO.Create;
  try
    for LIndice := Low(MODELOSCARROS) to High(MODELOSCARROS) do
    begin
      LCarro := TCarro.Create;
      try
        LCarro.IdCarro := dmSistemaSorteio.ObterMax('CARRO', 'IDCARRO') + 1;
        LCarro.Modelo := MODELOSCARROS[LIndice];
        LCarro.DataLancamento := Date;

        LDAO.Inserir(LCarro);
      finally
        LCarro.Free;
      end;
    end;
  finally
    LDAO.Free;
  end;
end;

end.
