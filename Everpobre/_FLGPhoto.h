// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FLGPhoto.h instead.

@import CoreData;
#import "FLGEverpobreBaseClass.h"

extern const struct FLGPhotoAttributes {
	__unsafe_unretained NSString *photoData;
} FLGPhotoAttributes;

extern const struct FLGPhotoRelationships {
	__unsafe_unretained NSString *notes;
} FLGPhotoRelationships;

@class FLGNote;

@interface FLGPhotoID : NSManagedObjectID {}
@end

@interface _FLGPhoto : FLGEverpobreBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FLGPhotoID* objectID;

@property (nonatomic, strong) NSData* photoData;

//- (BOOL)validatePhotoData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;

@end

@interface _FLGPhoto (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(FLGNote*)value_;
- (void)removeNotesObject:(FLGNote*)value_;

@end

@interface _FLGPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePhotoData;
- (void)setPrimitivePhotoData:(NSData*)value;

- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;

@end
