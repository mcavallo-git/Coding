HTML "Node" vs HTML "DOM" Differentiation
Citation: Dimitre Novatchev @ http://stackoverflow.com/questions/132564/whats-the-difference-between-an-element-and-a-node-in-xml

Thus, the DOM spec defines the following types of nodes:

Document -- Element (maximum of one), ProcessingInstruction,  Comment, DocumentType
DocumentFragment -- Element, ProcessingInstruction,  Comment, Text, CDATASection, EntityReference
DocumentType -- no children
EntityReference -- Element, ProcessingInstruction,  Comment, Text, CDATASection, EntityReference
Element -- Element, Text, Comment, ProcessingInstruction,  CDATASection, EntityReference
Attr -- Text, EntityReference
ProcessingInstruction -- no children
Comment -- no children
Text -- no children
CDATASection -- no children
Entity -- Element, ProcessingInstruction,  Comment, Text, CDATASection, EntityReference
Notation -- no children
The XML Infoset (used by XPath) has a smaller set of nodes:

The Document Information Item
Element Information Items
Attribute Information Items
Processing Instruction Information Items
Unexpanded Entity Reference Information Items
Character Information Items
Comment Information Items
The Document Type Declaration Information Item
Unparsed Entity Information Items
Notation Information Items
Namespace Information Items
XPath has the following Node types:

root nodes
element nodes
text nodes
attribute nodes
namespace nodes
processing instruction nodes
comment nodes
The answer to your question "What is the difference between an element and a node" is:

An element is a type of node. Many other types of nodes exist and serve different purposes.