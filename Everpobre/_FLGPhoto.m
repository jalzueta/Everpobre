// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FLGPhoto.m instead.

#import "_FLGPhoto.h"

const struct FLGPhotoAttributes FLGPhotoAttributes = {
	.photoData = @"photoData",
};

const struct FLGPhotoRelationships FLGPhotoRelationships = {
	.notes = @"notes",
};

@implementation FLGPhotoID
@end

@implementation _FLGPhoto

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Photo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:moc_];
}

- (FLGPhotoID*)objectID {
	return (FLGPhotoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic photoData;

@dynamic notes;

- (NSMutableSet*)notesSet {
	[self willAccessValueForKey:@"notes"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"notes"];

	[self didAccessValueForKey:@"notes"];
	return result;
}

@end

