package sample

import (
	"testing"
)

func TestCase(t *testing.T) {
	if _variable != "content" {
		t.Errorf("expected _variable to be \"content\" but got %v", _variable)
	}
}
