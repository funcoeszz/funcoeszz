$ zzphp json
Ds\Deque::jsonSerialize - Returns a representation that can be converted to JSON
Ds\Map::jsonSerialize - Returns a representation that can be converted to JSON
Ds\Pair::jsonSerialize - Returns a representation that can be converted to JSON
Ds\PriorityQueue::jsonSerialize - Returns a representation that can be converted to JSON
Ds\Queue::jsonSerialize - Returns a representation that can be converted to JSON
Ds\Set::jsonSerialize - Returns a representation that can be converted to JSON
Ds\Stack::jsonSerialize - Returns a representation that can be converted to JSON
Ds\Vector::jsonSerialize - Returns a representation that can be converted to JSON
JsonSerializable::jsonSerialize - Specify data which should be serialized to JSON
json_decode - Decodifica uma string JSON
json_encode - Retorna a representação JSON de um valor
json_last_error - Retorna o último erro ocorrido
json_last_error_msg - Retorna uma string contento a mensagem de erro da ultima chamada de json_encode() ou json_decode()
MongoDB\BSON\Binary::jsonSerialize - Returns a representation that can be converted to JSON
MongoDB\BSON\DBPointer::jsonSerialize - Returns a representation that can be converted to JSON
MongoDB\BSON\Decimal128::jsonSerialize - Returns a representation that can be converted to JSON
MongoDB\BSON\fromJSON - Returns the BSON representation of a JSON value
MongoDB\BSON\Int64::jsonSerialize - Returns a representation that can be converted to JSON
MongoDB\BSON\Javascript::jsonSerialize - Returns a representation that can be converted to JSON
MongoDB\BSON\MaxKey::jsonSerialize - Returns a representation that can be converted to JSON
MongoDB\BSON\MinKey::jsonSerialize - Returns a representation that can be converted to JSON
MongoDB\BSON\ObjectId::jsonSerialize - Returns a representation that can be converted to JSON
MongoDB\BSON\Regex::jsonSerialize - Returns a representation that can be converted to JSON
MongoDB\BSON\Symbol::jsonSerialize - Returns a representation that can be converted to JSON
MongoDB\BSON\Timestamp::jsonSerialize - Returns a representation that can be converted to JSON
MongoDB\BSON\toCanonicalExtendedJSON - Returns the Canonical Extended JSON representation of a BSON value
MongoDB\BSON\toJSON - Returns the Legacy Extended JSON representation of a BSON value
MongoDB\BSON\toRelaxedExtendedJSON - Returns the Relaxed Extended JSON representation of a BSON value
MongoDB\BSON\Undefined::jsonSerialize - Returns a representation that can be converted to JSON
MongoDB\BSON\UTCDateTime::jsonSerialize - Returns a representation that can be converted to JSON
$

$ zzphp ^xml_
xml_error_string - Obtém uma string de erro do analisador XML
xml_get_current_byte_index - Obtém o índice do byte atual para um analisador XML
xml_get_current_column_number - Obtém o número da coluna atual para um analisador XML
xml_get_current_line_number - Obtém o número da linha para um analisador XML
xml_get_error_code - Obtém um código de erro do analisador XML
xml_parse - Inicia a análise em um documento XML
xml_parser_create - Cria um analisador XML
xml_parser_create_ns - Cria um analisador XML com suporte a namespace
xml_parser_free - Free an XML parser
xml_parser_get_option - Obtém as opções de um analisador (parser) XML
xml_parser_set_option - Define opções em um analisador (parser) XML
xml_parse_into_struct - Analisa dados XML dentro de uma estrutura de array
xml_set_character_data_handler - Set up character data handler
xml_set_default_handler - Set up default handler
xml_set_element_handler - Set up start and end element handlers
xml_set_end_namespace_decl_handler - Set up end namespace declaration handler
xml_set_external_entity_ref_handler - Set up external entity reference handler
xml_set_notation_decl_handler - Set up notation declaration handler
xml_set_object - Use XML Parser within an object
xml_set_processing_instruction_handler - Set up processing instruction (PI) handler
xml_set_start_namespace_decl_handler - Set up start namespace declaration handler
xml_set_unparsed_entity_decl_handler - Set up unparsed entity declaration handler
$

$ zzphp _pad
array_pad - Expande um array para um certo comprimento utilizando um determinado valor
sodium_pad - Add padding data
str_pad - Preenche uma string para um certo tamanho com outra string
$

$ zzphp -d str_pad | sed 's/^ *//;/^ *$/d;s| *//.*||'
str_pad
(PHP 4 >= 4.0.1, PHP 5, PHP 7)
str_pad — Preenche uma string para um certo tamanho com outra string
Descrição
string str_pad ( string $input , int $pad_length [, string $pad_string [, int $pad_type ]] )
Esta função retorna a string input preenchida na esquerda, direita ou ambos os lados até o tamanho especificado. Se o parâmetro opcional pad_string não for indicado, input é preenchido com espaços, se não é preenchido com os caracteres de pad_string até o limite.
O parâmetro opcional pad_type pode ser STR_PAD_RIGHT (preencher a direita), STR_PAD_LEFT (preencher a esquerda), ou STR_PAD_BOTH (preencher de ambos os lados). If pad_type não for especificado é assumido que seja STR_PAD_RIGHT.
Se o valor de pad_length é negativo ou menor do que o tamanho da string , não há nenhum preenchimento.
Exemplo #1 Exemplo str_pad()
<?php
$input = "Alien";
print str_pad($input, 10);
print str_pad($input, 10, "-=", STR_PAD_LEFT);
print str_pad($input, 10, "_", STR_PAD_BOTH);
print str_pad($input, 6 , "___");
?>
Nota:
O parâmetro pad_string será truncado se se o número de caracteres de prenchimento não puder ser dividido igualmente pelo tamanho do parâmetro pad_string.
$
