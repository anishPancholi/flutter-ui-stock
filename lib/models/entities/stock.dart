import 'package:dart_mappable/dart_mappable.dart';

part 'stock.mapper.dart';

@MappableClass(ignoreNull: true, discriminatorValue: MappableClass.useAsDefault)
class StockSearchModel with StockSearchModelMappable {
  final String? id;
  final String? tenantId;
  final String? facilityId;
  final String? productVariantId;
  final String? referenceId;
  final String? referenceIdType;
  final String? transactingPartyId;
  final String? transactingPartyType;
  final String? receiverId;
  final String? receiverType;
  final String? senderId;
  final String? senderType;
  final List<String>? clientReferenceId;
  final List<String>? transactionType;
  final List<String>? transactionReason;
  final DateTime? dateOfEntryTime;

  StockSearchModel({
    this.id,
    this.tenantId,
    this.facilityId,
    this.productVariantId,
    this.referenceId,
    this.referenceIdType,
    this.transactingPartyId,
    this.transactingPartyType,
    this.receiverId,
    this.receiverType,
    this.senderId,
    this.senderType,
    this.clientReferenceId,
    this.transactionType,
    this.transactionReason,
    int? dateOfEntry,
  }) : dateOfEntryTime = dateOfEntry == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(dateOfEntry);

  @MappableConstructor()
  StockSearchModel.ignoreDeleted({
    this.id,
    this.tenantId,
    this.facilityId,
    this.productVariantId,
    this.referenceId,
    this.referenceIdType,
    this.transactingPartyId,
    this.transactingPartyType,
    this.receiverId,
    this.receiverType,
    this.senderId,
    this.senderType,
    this.clientReferenceId,
    this.transactionType,
    this.transactionReason,
    int? dateOfEntry,
  }) : dateOfEntryTime = dateOfEntry == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(dateOfEntry);

  int? get dateOfEntry => dateOfEntryTime?.millisecondsSinceEpoch;
}

@MappableClass(ignoreNull: true, discriminatorValue: MappableClass.useAsDefault)
class StockModel with StockModelMappable {
  final String? id;
  final String? tenantId;
  final String? facilityId;
  final String? productVariantId;
  final String? referenceId;
  final String? referenceIdType;
  final String? transactingPartyId;
  final String? transactingPartyType;
  final String? quantity;
  final String? wayBillNumber;
  final String? receiverId;
  final String? receiverType;
  final String? senderId;
  final String? senderType;
  final bool? nonRecoverableError;
  final String? clientReferenceId;
  final int? rowVersion;
  final String? transactionType;
  final String? transactionReason;
  final StockAdditionalDetails? additionalFields;
  final DateTime? dateOfEntryTime;

  StockModel({
    int? dateOfEntry,
    this.additionalFields,
    this.id,
    this.tenantId,
    this.facilityId,
    this.productVariantId,
    this.referenceId,
    this.referenceIdType,
    this.transactingPartyId,
    this.transactingPartyType,
    this.quantity,
    this.wayBillNumber,
    this.clientReferenceId,
    this.receiverId,
    this.receiverType,
    this.senderId,
    this.senderType,
    this.nonRecoverableError = false,
    this.rowVersion,
    this.transactionType,
    this.transactionReason,
  }) : dateOfEntryTime = dateOfEntry == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(dateOfEntry);

  int? get dateOfEntry => dateOfEntryTime?.millisecondsSinceEpoch;
}

@MappableClass(ignoreNull: true, discriminatorValue: MappableClass.useAsDefault)
class StockAdditionalDetails with StockAdditionalDetailsMappable {
  final String? version;
  final String? schema;
  final List<StockAdditinalField>? fields;

  StockAdditionalDetails({
    required this.version,
    this.schema = 'Stock',
    this.fields,
  });
}

@MappableClass(ignoreNull: true, discriminatorValue: MappableClass.useAsDefault)
class StockAdditinalField with StockAdditinalFieldMappable {
  final String? key;
  final dynamic value;

  StockAdditinalField({
    this.key,
    this.value,
  });
}
