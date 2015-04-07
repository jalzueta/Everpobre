// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FLGNotebook.m instead.

#import "_FLGNotebook.h"

const struct FLGNotebookAttributes FLGNotebookAttributes = {
	.creationDate = @"creationDate",
	.modificationDate = @"modificationDate",
	.name = @"name",
};

const struct FLGNotebookRelationships FLGNotebookRelationships = {
	.notes = @"notes",
};

@implementation FLGNotebookID
@end

@implementation _FLGNotebook

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Notebook" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Notebook";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Notebook" inManagedObjectContext:moc_];
}

- (FLGNotebookID*)objectID {
	return (FLGNotebookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic creationDate;

@dynamic modificationDate;

@dynamic name;

@dynamic notes;

- (NSMutableSet*)notesSet {
	[self willAccessValueForKey:@"notes"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"notes"];

	[self didAccessValueForKey:@"notes"];
	return result;
}

@end

