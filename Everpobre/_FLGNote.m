// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FLGNote.m instead.

#import "_FLGNote.h"

const struct FLGNoteAttributes FLGNoteAttributes = {
	.creationDate = @"creationDate",
	.modificationDate = @"modificationDate",
	.name = @"name",
	.text = @"text",
};

const struct FLGNoteRelationships FLGNoteRelationships = {
	.location = @"location",
	.notebook = @"notebook",
	.photo = @"photo",
};

@implementation FLGNoteID
@end

@implementation _FLGNote

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Note";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Note" inManagedObjectContext:moc_];
}

- (FLGNoteID*)objectID {
	return (FLGNoteID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic creationDate;

@dynamic modificationDate;

@dynamic name;

@dynamic text;

@dynamic location;

@dynamic notebook;

@dynamic photo;

@end

